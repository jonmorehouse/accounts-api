t = require 'test-bootstrap'
{Client} = libRequire 'client'
should = require 'should'

describe "Client", ->

  describe "create client", =>

    it "should create a postgresql entry and redis entry", (cb) =>

      Client.create (err, client) ->

        p client
        p err
        cb?()

