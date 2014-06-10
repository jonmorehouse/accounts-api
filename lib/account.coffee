require "./bootstrap"
bs = require "./bootstrap"
sql = require 'sql'
async = require 'async'
v = require 'validator'
mc = require 'multi-config'
bcrypt = require 'bcrypt'

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
    },
    {
      name: "encrypted_password"
      dataType: "varchar(255)"
    },
    {
      name: "username"
      dataType: "varchar(255)"
    },
    {
      name: "signup_date"
      dataType: "timestamp"
    },
    {
      name: "last_login"
      dataType: "timestamp"
    }
  ]

class Account

  constructor: (kw, cb) ->


  @create: (kw, cb) =>
    

    # make sure required account credentials are not already taken
    @_find kw, (err, obj) =>
      if obj?
        return cb new Error "Account exists already" 

      # need to validate all credentials
      async.parallel [
        ((cb) => @_validateEmailAddress kw.emailAddress, cb),
        ((cb) => @_validatePhoneNumber kw.phoneNumber, cb),
        ((cb) => @_validatePassword kw.password, cb),
        ((cb) => @_validateUsername kw.username, cb),
      ], (err) =>
        return cb? err if err

        # hash password and prepare for insert
        @_hashPassword kw.password, (err, hash) ->

          return cb? err if err?

          cb?()

  @_find: (kw, cb) ->

    query = table.select(table.star()).from(table)
    orRequired = false

    # loop through keys we can find on
    for index, key in ["emailAddress", "username", "phoneNumber"]
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

  @_validatePhoneNumber: (phoneNumber, cb) ->

    phoneNumber = phoneNumber.replace "-", ""
    if not v.isNumeric phoneNumber
      return cb new Error "Invalid phone number characters"
    if not v.isLength phoneNumber, 10
      return cb new Error "Invalid phone number length"

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
  
module.exports =

  Account: Account
  table: table


