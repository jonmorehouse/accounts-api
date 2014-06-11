#flow-command: /usr/bin/time mocha -R dot --no-exit --compilers coffee:coffee-script/register ~/Documents/programs/accounts-api/test/spec/account_spec.coffee
t = require 'test-bootstrap'
account = libRequire 'account'
should = require 'should'

describe "Account", ->
  beforeEach (cb) =>

    @kw = 
      username: "username"
      password: "password"
      emailAddress: "email@address.com"

    cb?()

  describe "new account", =>

    it "should add a new account to the database", (cb) =>

      account.Account.create @kw, (err, acc) =>

        should.not.exist err
        should.exist acc
        # now when we use the account.find it should work okay!
        cb?()


  describe "authentication", =>

    beforeEach (cb) =>
      account.Account.create @kw, cb

    it "should be able to authenticate an existing account", (cb) =>
        account.Account.authenticate @kw, (err, acc) =>

          should.not.exist err
          should.exist acc
          cb?()

    it "should not authenticate with an account with the wrong password", (cb) =>

      @kw.password = "wrong_password"
      account.Account.authenticate @kw, (err, acc) =>

        should.not.exist acc
        should.exist err
        cb?()




