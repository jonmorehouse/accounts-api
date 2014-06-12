t = require 'test-bootstrap'
b = libRequire 'bootstrap'
account = libRequire 'account'
async = require 'async'
should = require 'should'

# call each method of an object
objCaller = (obj, cb) ->
  async.parallel (obj[key] for key of obj), (err) ->
    return cb? err if err?
    cb?()

_setUpEach = 
  postgres: (cb) ->
    # create tables for test
    b.app.postgres.query account.table.create().ifNotExists().toQuery().text, (err, res) -> 
      should.not.exist err
      should.exist res
      cb?()

# declare a bunch of methods
_setUp = 
  app: (cb) ->
    b.setUp (err, _app) ->
      should.not.exist err
      should.exist _app
      cb?()

  testClient: (cb) ->

    t.client = restify.createJsonClient 
      url: "#{mc.httpHost}:#{mc.httpPort}"
      version: mc.version
    
    cb?()

_tearDown = 
  app: (cb) ->
    b.tearDown (err) ->
      should.not.exist err
      cb?()

_tearDownEach =

  postgres: (cb) ->
    b.app.postgres.query account.table.drop().ifExists().toQuery().text, (err, res) ->
      cb? err if err?
      cb?()

  redis: (cb) ->
    b.app.redis.send_command "flushall", [], cb

# map mocha hooks to the correct methods
before ((cb) -> objCaller _setUp, cb)
after ((cb) -> objCaller _tearDown, cb)
beforeEach ((cb) -> objCaller _setUpEach, cb)
afterEach ((cb) -> objCaller _tearDownEach, cb)

