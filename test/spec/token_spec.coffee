t = require 'test-bootstrap'
should = require 'should'
bs = libRequire "bootstrap"
h = testRequire "helpers"
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


   


