Appstrap = require 'appstrap'
mc = require 'multi-config'
app = null
configNamespace = "accounts_service"

setUp = (cb) ->

  # now set up appstrap
  mc.env ["ETCD_HOST", "ETCD_PORT"], ->

    # now grab the configuration for this application
    mc.etcd configNamespace, {namespace: false}, (err) ->

      # now set up appstrap
      new Appstrap (err, _app) ->

        # handle results
        cb? err if err
        app = _app
        cb? err, _app

tearDown = (cb) ->

  app.on "close", (_cb) ->
    # do some closing tasks if needed
    _cb?()
  app.close (err) ->
    cb?()

module.exports = 

  app: app
  setUp: setUp
  tearDown: tearDown


