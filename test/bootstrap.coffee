should = require 'should'
b = libRequire 'bootstrap'
app = null
account = libRequire "account"

clearDatabase = (cb) ->

  # clear the database
  app.postgres.query account.table.drop().toQuery().text, (err, res) ->
    cb?()

seedDatabase = (cb) ->

  # create tables for test
  app.postgres.query account.table.create().toQuery().text, (err, res) -> 

    should.not.exist err
    should.exist res
    cb?()

beforeEach (cb) ->
  b.setUp (err, _app) ->

    should.not.exist err
    should.exist _app
    app = _app

    # seed database
    seedDatabase ->
      cb?()

afterEach (cb) ->
  clearDatabase ->
    b.tearDown (err) ->

      cb?()



