sql = require 'sql'
async = require 'async'
v = require 'validator'
mc = require 'multi-config'
bcrypt = require 'bcrypt'
bs = require "./bootstrap"

# declare table for accounts
table = sql.Table.define
  name: "account"
  columns: [
    {
      name: "id"
      dataType: "uuid"
      primaryKey: true
    },
    {
      name: "email_address"
      dataType: "varchar(255)"
      property: "emailAddress"
    },
    {
      name: "encrypted_password"
      dataType: "varchar(255)"
      property: "encryptedPassword"
      private: false
    },
    {
      name: "username"
      dataType: "varchar(255)"
    },
    {
      name: "signup_date"
      dataType: "timestamp"
      property: "signupDate"
    },
    {
      name: "last_login"
      dataType: "timestamp"
      property: "loginDate"
    }
  ]
publicColumns = (column for column in table.columns when not column.private?)

class Account

  @authenticate: (kw, cb) =>

    if not kw.password? or not kw.username? and not kw.emailAddress? 
      return cb? new Error "Missing parameters"

    @_hashPassword kw.password, (err, hash) =>
      return cb? err if err
    
      key = if kw.username? then "username" else if kw.emailAddress? then "emailAddress"
      query = table.select(publicColumns...).where(table[key].equals(kw[key])).and(table.encryptedPassword.equals(hash)).toQuery()

      # make proper query and return to the caller
      bs.app.postgres.query query, (err, res) ->
        return cb? err if err
        return cb? new Error "Unable to authenticate" if res.rows.length != 1 
        return cb? null, res.rows[0]

  @create: (kw, cb) =>
    
    # make sure required account credentials are not already taken
    @find kw, (err, obj) =>
      if obj?
        return cb new Error "Account exists already" 

      # need to validate all credentials
      async.parallel [
        ((cb) => @_validateEmailAddress kw.emailAddress, cb),
        ((cb) => @_validatePassword kw.password, cb),
        ((cb) => @_validateUsername kw.username, cb),
      ], (err) =>
        return cb? err if err

        # hash password and prepare for insert
        @_hashPassword kw.password, (err, hash) =>
          return cb? err if err?
          kw.encryptedPassword = hash
          @_insertAccount kw, (err, account) ->
            cb? err if err?
            cb null, account

  @find: (kw, cb) ->

    # set up query
    query = table.select(publicColumns...).from(table)
    orRequired = false

    # loop through keys we can find on
    for index, key in ["emailAddress", "username", "encryptedPassword"]
      if kw[key]?
        # see if its the second where statement
        if orRequired
          query = query.or
        query = query.where(table[key].equals(kw[key]))

    # now see the number of rows that exist
    bs.app.postgres.query query.toQuery().text, (err, res) ->
      return cb? err if err
      if res.rows.length == 1
         return cb null, res.rows[0]
      return cb err, null

  @_validateEmailAddress: (emailAddress, cb) ->

    if not typeof emailAddress is "string"
      return cb new Error "Invalid email address length"
    if not v.isLength emailAddress, 4, 254
      return cb new Error "Invalid email address length"
    if not v.isEmail emailAddress
      return cb new Error "Invalid email address"

    cb?()

  @_validatePassword: (password, cb) ->

    if not v.isLength password, 8, 100
      return cb new Error "Invalid password length"

    cb?()

  @_validateUsername: (username, cb) ->
    re = /^[a-z,A-Z,\.\'-_]*$/
    if not v.isLength username, 1, 100
      return cb new Error "Invalid username length"

    if not username.match re
      return cb new Error "Invalid characters"

    cb?()

  @_hashPassword: (password, cb) ->

    bcrypt.hash password, bs.app.bcryptSalt, (err, hash) ->
      return cb? err if err
      cb null, hash

  @_insertAccount: (kw, cb) ->

    columns = (column.property for column in table.columns)
    obj = {}

    for column in columns
      ((column) ->
        switch column
          when "id" then obj[column] = table.sql.functions.uuid_generate_v4()
          when "signupDate", "loginDate" then obj[column] = table.sql.functions.now()
          else obj[column] = kw[column] if kw[column]?
      )(column)

    # generate text and insert into datbase
    query = table.insert(obj).returning(publicColumns...).toQuery()
    bs.app.postgres.query query, (err, res) ->
      return cb? err if err?
      cb? null, res.rows[0]

module.exports =
  Account: Account
  table: table

