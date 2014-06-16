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
    }
  ]

class Token

  @create: (kw, cb) ->

    # authenticate client
    # find account / authenticate account
    Client.authenticate kw, (err, validated) =>
      return cb? err if err? or not validated

      Account.authenticate kw, (err, account) =>
        return cb? err if err?
        return cb null, account
        cb?()


  @authenticate: (token, cb) ->


  @delete: (token, cb) ->

    # do a join against the property

  @_newToken: (accountId, cb) ->


module.exports =
  table: table
  setKey: setKey
  Token: Token

