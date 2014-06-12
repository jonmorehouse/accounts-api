mc = require 'multi-config'
Appstrap = require 'appstrap'
extend = require 'extend'
bcrypt = require 'bcrypt'
async = require 'async'
sql = require 'sql'
server = require "./server"

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
    server.setUp exports.app, cb

_tearDown = 
  server: (cb) ->
    server.tearDown exports.app, cb

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
    # pre-appstrap teardown methods
    async.parallel (_tearDown[key] for key of _tearDown), (err) ->
      return cb? err if err?
      _cb?()

  exports.app.close (err) ->
    # application is fully closed / shutoff
    cb?()


