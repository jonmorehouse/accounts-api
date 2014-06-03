mc = require 'multi-config'
app = null
configNamespace = "accounts-service"

setUp = (cb) ->

  # now set up appstrap
  mc.env ["ETCD_HOST", "ETCD_PORT"], ->

    # now grab the configuration for this application
    mc.etcd configNamespace, ->
      cb?()

module.exports = 

  app: app
  setUp: setUp







