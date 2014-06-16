t = require 'test-bootstrap'
{Client,table} = libRequire 'client'
should = require 'should'
bs = libRequire "bootstrap"


describe "Client", ->

  describe "create client", =>

    beforeEach (cb) =>
      Client.create (err, client) =>

        should.not.exist err
        should.exist client
        @client = client

        cb?()

    it "should return an account", (cb) =>

      should.exist @client
      should.exist @client.clientId
      should.exist @client.clientSecret

      cb?()

    it "should persist the client to the datastore", (cb) =>

      # create select query
      query = table.select(table.select(table.clientId))
      query.where(table.clientId.equals(@client.clientId), table.clientSecret.equals(@client.clientSecret))
    
      #make request
      bs.app.postgres.query query, (err, res) ->

        should.not.exist err
        should.exist res

        cb?()

    it "should persist the client to the redis datastore", (cb) =>

      cb?()




