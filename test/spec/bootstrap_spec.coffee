t = require 'test-bootstrap'
b = libRequire 'bootstrap'
c = require 'multi-config'
should = require 'should'

describe "Bootstrap", ->

    beforeEach (cb) =>
      b.setUp (err, @app) =>
        cb?()

    afterEach (cb) =>
      b.tearDown (err) ->
        cb?()

    it "should properly load configuration", (cb) =>

      b.setUp (err, app) ->
        # now make sure that the relevant keys are set
        #should.exist c.postgres
        #should.exist c.redis
        cb?()

    it "should properly create app", (cb) =>

      b.setUp (err, app) ->

        cb?()

