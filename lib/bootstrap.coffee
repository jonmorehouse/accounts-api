mc = require 'multi-config'
app = null
configNamespace = "accounts_service"
Appstrap = require 'appstrap'

setUp = (cb) ->

  # now set up appstrap
  mc.env ["ETCD_HOST", "ETCD_PORT"], ->

    # now grab the configuration for this application
    mc.etcd configNamespace, {namespace: false}, (err) ->

      # now set up appstrap
      new Appstrap (err, _app) ->

        p err
        # configuration is now loaded
        cb?()

tearDown = (cb) ->

  cb?()

module.exports = 

  app: app
  setUp: setUp
  tearDown: tearDown







