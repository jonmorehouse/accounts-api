t = require 'test-bootstrap'
should = require 'should'
async = require 'async'
h = testRequire "helpers"
extend = require 'extend'

describe "Authentication controller", ->

  beforeEach (cb) =>
    h.createClient (@client) =>
      h.createAccount (@acc) =>
        cb?()

  describe "create a new token", =>

    beforeEach (cb) =>
      @kw = 
        clientSecret: @client.clientSecret
        clientId: @client.clientId
        password: @acc.password
        username: @acc.username
        grant_type: "password"
        tokenType: "bearer"
      cb()

    it "should return a token when given the correct credentials", (cb) =>

      t.client.post "/token", @kw, (err, req, res, obj) =>

        cb?()


