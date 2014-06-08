require "./bootstrap"
bs = require "./bootstrap"
sql = require 'sql'
async = require 'async'

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

    # account should be a new account

  @create: (kw, cb) ->
    
    # find the current username with object
    @_find kw, (err, obj) ->

      cb?()
      

  @_find: (kw) ->

    query = table.select(table.star()).from(table)
    orRequired = false

    # loop through keys we can find on
    for index, key in ["emailAddress", "username", "phoneNumber"]
      if kw[key]?
        # see if its the second where statement
        if orRequired
          query = query.or
        query = query.where(table[key].equals(kw[key]))

    p query.toQuery().text
    # now see the number of rows that exist
    bs.app.postgres.query query.toQuery().text, (err, rows) ->

      p err
      p rows
      cb?() 


  _validateEmailAddress: (emailAddress, cb) ->

  _validatePhoneNumber: (phoneNumber, cb) ->

  _validatePassword: (password, cb) ->

  _validateUsername: (username, cb) ->

  _hashPassword: (password, cb) ->




module.exports =

  Account: Account
  table: table


