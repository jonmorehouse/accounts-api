sql = require 'sql'
async = require 'async'
mc = require 'multi-config'
bs = require "./bootstrap"

# redis set
setKey = "client"

table = sql.Table.define
  name: "client_credentials"
  columns: [
    {
      name: "client_id"
      primaryKey: true
      dataType: "uuid"
    },
    {
      name: "client_secret"
      dataType: "uuid"
      required: true
    }
  ]


class Client 

  constructor: (cb) ->

  @create: (cb) =>
    @_create (err, acc) =>
      cb? err if err?
      return cb err, acc
      @_redisEntry client, (err) =>
        cb? err if err?
        cb null, acc
    
  @authenticate: (clientId, clientSecret) =>

    # authenticate the client ... make sure the account exists etc
    # check if key exists

  @_create: (cb) =>

    # generate insert object
    obj = {}
    for column in (column.property for column in table.columns)
      ((column) ->
        obj[column] = table.sql.functions.uuid_generate_v4()
      )(column)

    # generate the query and insert into the table
    query = table.insert(obj).returning(table.star()).toQuery()
    bs.app.postgres.query query, (err, res) ->
      cb? err if err?
      cb? null, res.rows[0]

  @_redisEntry: (client, cb) =>

    cb?()


module.exports = 
  table: table
  Client: Client
  setKey: setKey



