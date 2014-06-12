Appstrap = require 'appstrap'
mc = require 'multi-config'
extend = require 'extend'
bcrypt = require 'bcrypt'
async = require 'async'
sql = require 'sql'
restify = require 'restify'

# application wide variables
exports.app = {}
configNamespace = "accounts_service"

_setUp = 
  bcrypt: (cb) ->

    mc.bcrypt.saltRounds = parseInt mc.bcrypt.saltRounds
    bcrypt.genSalt mc.bcrypt.saltRounds, (err, salt) ->
      return cb? err if err
      exports.app.bcryptSalt = salt
      cb?()

  sql: (cb) ->

    sql.registerFunctions ["uuid_generate_v4", "now"]
    cb?()

  server: (cb) ->

    # create server
    s = restify.createServer 
      name: mc.serverName
      version: mc.version

    # restify directives
    s.use restify.acceptParser s.acceptable
    s.use restify.queryParser()
    s.use restify.bodyParser()

    cb?()

exports.setUp = (cb) ->

  # now set up appstrap
  mc.env ["ETCD_HOST", "ETCD_PORT"], ->

    # now grab the configuration for this application
    mc.etcd configNamespace, {namespace: false}, (err) ->

      # now set up appstrap
      new Appstrap (err, _app) ->

        # handle results
        cb? err if err
      
        # merge the _app to the normal app to allow for cleaner, easier and guaranteed expected requires
        extend true, exports.app, _app

        # call all setupMethods 
        async.parallel (_setUp[key] for key of _setUp), (err) ->
          return cb? err, _app

exports.tearDown = (cb) ->

  exports.app.on "close", (_cb) ->
    # do some closing tasks if needed
    _cb?()
  exports.app.close (err) ->
    cb?()


