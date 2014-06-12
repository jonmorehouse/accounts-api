t = require 'test-bootstrap'
b = libRequire 'bootstrap'
should = require 'should'
c = require 'multi-config'

describe "Bootstrap", ->

  it "should properly load configuration", (cb) ->

    # now make sure that the relevant keys are set
    should.exist c.postgres
    should.exist c.redis
    cb?()

  it "should properly create app", (cb) =>

    should.exist b.app
    should.exist b.app.postgres
    should.exist b.app.redis
    cb?()

