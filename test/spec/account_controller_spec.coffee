t = require 'test-bootstrap'
ch = require 'charlatan'

describe "AccountController", ->

  before (cb) =>

    @kw = 
      username: ch.Internet.userName()
      password: ch.Internet.password()

    cb?()


  describe "post account/", =>

    it "should create a new account", (cb) =>
      t.client.post "/account", @kw, (err, req, res, obj) =>

        cb?()





