t = require 'test-bootstrap'

t = ->

describe "AccountController", ->

  describe "post account/", ->

    it "should create a new account", (cb) ->

      t.client.get "/", (err, req, res, obj) =>

        cb?()



