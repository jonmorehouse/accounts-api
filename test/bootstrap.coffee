mc = require 'multi-config'
t = require 'test-bootstrap'
async = require 'async'
should = require 'should'
restify = require 'restify'
b = libRequire 'bootstrap'
account = libRequire 'account'

# call each method of an object
objCaller = (obj, args...) ->
  cb = args[args.length - 1]
  method = if args.length > 1 then args[0] else async.parallel
  method (obj[key] for key of obj), (err) ->
    return cb? err if err?
    cb?()

_setUpEach = 
  postgres: (cb) ->
    # create tables for test
    b.app.postgres.query account.table.create().ifNotExists().toQuery().text, (err, res) -> 
      should.not.exist err
      should.exist res
      cb?()

_setUp = 

  env: (cb) ->
    mc.ENV = "test"
    cb?()

  app: (cb) ->
    b.setUp (err, _app) ->
      should.not.exist err
      should.exist _app
      cb?()

  testClient: (cb) ->

    t.client = restify.createJsonClient 
      url: "http://#{mc.httpHost}:#{mc.httpPort}"
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
before ((cb) -> objCaller _setUp, async.series, cb)
after ((cb) -> objCaller _tearDown, cb)
beforeEach ((cb) -> objCaller _setUpEach, cb)
afterEach ((cb) -> objCaller _tearDownEach, cb)

