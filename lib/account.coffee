require "./bootstrap"
{app} = require "./bootstrap"
sql = require 'sql'

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
      name: "password"
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

  @constructor: ->

    # set up application account
    # attributes [bid, cid]
  
  # create a new account
  @create: (username, emailAddress, unencryptedPassword) ->

    # create a new account
    p username
    p emailAddress
    p unencryptedPassword

  @username: (username) ->
  
    # returns uid if username exists
    # returns false if not

  @email: (emailAddress) ->
  
    # returns uid if emailExists
    # returns false if not

  @authenticate: (uid, password) -> 

    # run authentication against database


  # private methods
  getUid: (column, value) -> 

  encryptPassword: (password) ->

    # return encrypyted / salted password


module.exports =

  Account: Account
  table: table


