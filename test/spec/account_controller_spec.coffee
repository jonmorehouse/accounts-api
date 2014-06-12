t = require 'test-bootstrap'

describe "AccountController", ->

  describe "post account/", ->

    it "should create a new account", (cb) =>

      t.client.get "/", (err, req, res, obj) =>
        p obj
        cb?()



