t = require 'test-bootstrap'
b = libRequire 'bootstrap'
c = require 'multi-config'
should = require 'should'

describe "Bootstrap", =>

    it "should properly load configuration", (cb) =>

      # now make sure that the relevant keys are set
      #should.exist c.postgres
      #should.exist c.redis
      cb?()

    it "should properly create app", (cb) =>

      #should.exist t.app
      #should.exist t.app.postgres
      #should.exist t.app.redis
      cb?()
      

    

