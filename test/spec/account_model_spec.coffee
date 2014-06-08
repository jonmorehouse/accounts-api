require 'should'
t = require 'test-bootstrap'
account = libRequire 'account'

describe "Account", ->
  describe "new account", ->

    beforeEach (cb) =>

      @kw = 
        username: "username"
        password: "password"
        phoneNumber: "2137401111"
        emailAddress: "email@address.com"

      cb?()


    it "should pass an error to the callback with invalid parameters", (cb) =>

      cb?()
      return
      delete @kw.username
      account.Account.create @kw, (err, acc) =>

        cb?()

    it "should add a new account to the database", (cb) ->


      cb?()

    




