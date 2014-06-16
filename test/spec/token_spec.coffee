t = require 'test-bootstrap'
should = require 'should'
bs = libRequire "bootstrap"
h = testRequire "helpers"
sql = require 'sql'
{Token} = libRequire "token"

#[Token,table,setKey] = libRequire 'token'
describe "Token", ->

  beforeEach (cb) =>
    h.tokenRequestKw (@kw) =>
      cb?()

  describe "create tokens", =>

    it "should create a token when an account is passed to Token.createFromAccount", (cb) =>
      Token.create @kw, (err, token) =>
        should.not.exist err
        should.exist token
        cb?()

    #it "should add a record to the database", (cb) =>
      #Token.create @kw, (err, token) =>
        #bs.app 

  describe "token authentication", =>

    beforeEach (cb) =>
      Token.create @kw, (err, @token) =>
        should.not.exist err
        should.exist @token
        cb?()

    it "should allow reauthentication on subsequent requests", (cb) =>
      
      Token.authenticate @token, (err, auth) =>

        should.not.exist err
        should.exist auth
        should.exist auth.accountId
        should.exist auth.accountId, @kw.id

        cb?()
   

