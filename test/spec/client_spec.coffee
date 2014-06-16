t = require 'test-bootstrap'
{Client,table,setKey} = libRequire 'client'
should = require 'should'
bs = libRequire "bootstrap"

describe "Client", ->

  beforeEach (cb) =>
    Client.create (err, client) =>

      should.not.exist err
      should.exist client
      @client = client

      cb?()

  describe "create client", =>


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
 
      bs.app.redis.hget setKey, @client.clientId, (err, res) =>
        should.not.exist err
        should.exist res
        should.equal res, @client.clientSecret
        cb?()

  describe "authenticate client", =>

    it "should be able to authenticate a client id", (cb) =>

      Client.authenticate @client, (err, authenticated) =>

        should.not.exist err
        should.equal true, authenticated

        cb?()

    it "should not authenticate with invalid clientId or clientSecret", (cb) =>

      @client.clientSecret = "not a client secret"
      Client.authenticate @client, (err, authenticated) =>

        should.exist err
        should.exist authenticated
        should.equal authenticated, false
        cb?()

