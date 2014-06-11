require 'should'
t = require 'test-bootstrap'
account = libRequire 'account'

describe "Account", ->
  describe "new account", ->

    beforeEach (cb) =>

      @kw = 
        username: "username"
        password: "password"
        emailAddress: "email@address.com"

      cb?()

    it "should add a new account to the database", (cb) =>

      account.Account.create @kw, (err, acc) =>

        # now when we use the account.find it should work okay!
        cb?()


