require "./bootstrap"
{app} = require "./bootstrap"

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


