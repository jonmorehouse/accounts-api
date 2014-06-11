b = libRequire 'bootstrap'
{app} = libRequire 'bootstrap'
async = require 'async'
account = libRequire "account"
should = require 'should'
t = require 'test-bootstrap'

clearDatabase = (cb) ->

  async.parallel [
    ((cb) ->
      app.postgres.query account.table.drop().ifExists().toQuery().text, (err, res) ->
        cb? err if err?
        cb?()
    ),((cb) ->
      app.redis.send_command "flushall", [], cb
    )
  ], (err) ->
    cb?()

seedDatabase = (cb) ->

  # create tables for test
  app.postgres.query account.table.create().ifNotExists().toQuery().text, (err, res) -> 
    should.not.exist err
    should.exist res
    cb?()

before (cb) ->
  t.benchmark.start "suite"
  b.setUp (err, _app) ->
    should.not.exist err
    should.exist _app
    cb?()

after (cb) ->
  b.tearDown (err) ->
    t.benchmark.stop "suite"
    cb?()

beforeEach seedDatabase
afterEach clearDatabase

