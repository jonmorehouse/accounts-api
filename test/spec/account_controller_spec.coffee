t = require 'test-bootstrap'
ch = require 'charlatan'
should = require 'should'
async = require 'async'
{Account} = libRequire "account"

getKw = ->
    username: ch.Internet.userName()
    emailAddress: ch.Internet.freeEmail()
    password: ch.Internet.password 10

describe "AccountController", ->

  beforeEach (cb) =>

    @kw = getKw()
    cb?()

  describe "client test", =>

    it "should make a request and get a response", (cb) =>
      t.client.get "/account", (err, req, res, obj) =>
        should.not.exist err
        should.exist obj
        cb?()

  describe "account creation", =>

    it "should create a new account", (cb) =>
      t.client.post "/account", @kw, (err, req, res, obj) =>
        should.not.exist err
        should.exist obj
        obj.username.should.equal @kw.username
        obj.emailAddress.should.equal @kw.emailAddress
        res.statusCode.should.equal 201
        cb?()

    it "should not create an account with missing parameters", (cb) =>

      delete @kw.password
      t.client.post "/account", @kw, (err, req, res, obj) =>
        res.statusCode.should.equal 400
        obj.should.exist
        cb?()

    it "should not allow for the creation of an existing account", (cb) =>

      # create account
      Account.create @kw, (err, acc) =>
        t.client.post "/account", @kw, (err, req, res, obj) =>
          res.statusCode.should.equal 400
          obj.should.exist
          cb?()

  describe "account discovery", =>
    beforeEach (cb) =>
      @kw = getKw()
      Account.create @kw, (err, acc) =>
        should.not.exist err
        should.exist acc
        @acc = acc 
        cb?()

    it "should return 200 for a username lookup", (cb) =>

      queryKeys = ["username", "emailAddress", "id"]

      _ = (key, cb) =>
        t.client.get "/account?username=#{@acc[key]}", (err, req, res, obj) =>

          should.not.exist err
          should.exist obj

          # loop through all queryable keys
          for key in queryKeys
            should.exist obj[key]
            should.equal obj[key], @acc[key]

          cb?()

      # now look up account as needed
      async.each queryKeys, _, cb


