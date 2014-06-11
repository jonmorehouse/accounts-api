should = require 'should'
b = libRequire 'bootstrap'
{app} = libRequire 'bootstrap'
async = require 'async'
account = libRequire "account"
require 'jasmine-before-all'

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

beforeEach (cb) ->
  b.setUp (err, _app) ->
    should.not.exist err
    should.exist _app
    seedDatabase cb

afterEach (cb) ->
    clearDatabase ->
      b.tearDown (err) ->
        cb?()


