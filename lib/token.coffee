bs = require "./bootstrap"
sql = require 'sql'
{Account} = require "./account"
{Client} = require "./client"

setKey = "token"

table = sql.Table.define
  name: "token"
  columns: [
    {
      name: "token"
      primaryKey: true
      dataType: "uuid"
    },
    {
      name: "account_id"
      dataType: "uuid"
      required: true
      property: "accountId"
    }, 
    {
      name: "created_at"
      dataType: "timestamp"
      required: true
      property: "createdAt"
    },
    {
      name: "modified_at"
      dataType: "timestamp"
      property: "modifiedAt"
    },
    {
      name: "expired"
      dataType: "boolean"
      default: false
    }
  ]

class Token

  @create: (kw, cb) ->
    Client.authenticate kw, (err, validated) =>
      return cb? err if err? or not validated

      Account.authenticate kw, (err, account) =>
        return cb? err if err? or not account?

        # both client and account have been authed... create a bearer token
        @_createToken account, (err, token) =>
          return cb? err if err?

          # update redis store
          @_hashEntry token, (err) =>
            return cb? err if err?
            cb? null, token

  @authenticate: (token, cb) ->
    token = if typeof token == "object" then token.token else token

    # authenticate against the current token
    bs.app.redis.hget setKey, token, (err, res) ->
      return cb? err if err? or not res? or not res
      return cb? null, 
        accountId: res
        authenticated: true

  @delete: (token, cb) ->

    token = if typeof token is "object" then token.token else token
    # remove redis hash
    bs.app.redis.hdel setKey, token, (err) =>
      return cb? err if err?

      obj = 
        modifiedAt: table.sql.functions.now()
        expired: true

      p err
      p obj

      # build query
      query = table.update({}).toQuery()

      p query.text

      return cb?()
        
      # execute query against datastore
      bs.app.postgres.query query, (err, res) ->
        return cb? err if err?
        return cb? null, res.rows[0]

  @_createToken: (account, cb) ->

    obj = 
      accountId: account.id
      token: table.sql.functions.uuid_generate_v4()
      created_at: table.sql.functions.now()

    # update application
    query = table.insert(obj).returning(table.star()).toQuery()
    bs.app.postgres.query query, (err, res) ->
      return cb? err if err?
      return cb? null, res.rows[0]

  @_hashEntry: (token, cb) ->
    bs.app.redis.hset setKey, token.token, token.accountId, (err) ->
      return cb? err


module.exports =
  table: table
  setKey: setKey
  Token: Token

