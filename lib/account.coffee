
class Account

  @constructor: ->

    # set up application account
    # attributes [bid, cid]
  
  @create: (username, emailAddress, password) ->

    # create a new account

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


