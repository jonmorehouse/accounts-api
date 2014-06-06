mc = require 'multi-config'
app = null
configNamespace = "accounts_service"

setUp = (cb) ->

  # now set up appstrap
  mc.env ["ETCD_HOST", "ETCD_PORT"], ->

    # now grab the configuration for this application
    mc.etcd configNamespace, (err) ->

      # configuration is now loaded
      cb?()

module.exports = 

  app: app
  setUp: setUp







