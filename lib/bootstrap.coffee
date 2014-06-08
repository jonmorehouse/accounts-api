Appstrap = require 'appstrap'
mc = require 'multi-config'
extend = require 'extend'
exports.app = {}
configNamespace = "accounts_service"

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

        cb? err, _app

exports.tearDown = (cb) ->

  exports.app.on "close", (_cb) ->
    # do some closing tasks if needed
    _cb?()
  exports.app.close (err) ->
    cb?()


