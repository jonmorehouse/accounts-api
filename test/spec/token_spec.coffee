t = require 'test-bootstrap'
should = require 'should'
bs = libRequire "bootstrap"
h = testRequire "helpers"

#[Token,table,setKey] = libRequire 'token'
describe "Token", ->

  beforeEach (cb) =>
    h.createAccount (@account) =>
      cb?()

  describe "create new token", =>

    it "should return a new token", (cb) =>

      p @account

      cb?()


   


