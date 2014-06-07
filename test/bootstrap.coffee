should = require 'should'
b = libRequire 'bootstrap'
app = null

beforeEach (cb) ->

  b.setUp (err, _app) ->

    should.not.exist err
    should.exist _app
    app = _app
    cb?()

afterEach (cb) ->
  
  b.tearDown (err) ->

    cb?()



