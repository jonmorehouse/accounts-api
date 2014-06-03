t = require 'test-bootstrap'
b = libRequire 'bootstrap'
mc = require 'multi-config'

describe "Bootstrap", ->

  describe "Bootstrap setup", ->

    it "this is for manual testing", (cb) ->

      b.setUp (err, app) ->

        p mc.etcd.host

        cb?()

        





