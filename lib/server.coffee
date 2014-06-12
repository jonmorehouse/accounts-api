restify = require 'restify'
mc = require 'multi-config'
b = require "./bootstrap"

exports.setUp = (app, cb) ->

  # create server
  s = restify.createServer 
    name: mc.name
    version: mc.version

  # restify directives
  s.use restify.acceptParser s.acceptable
  s.use restify.queryParser()
  s.use restify.bodyParser()
  
  b.app.server = s
  require "./account_controller"

  # listen on server port and link up with global application
  s.listen mc.httpPort, =>
    return cb?()

exports.tearDown = (app, cb) ->

  app.server.close (err) ->
    return cb? err if err?
    cb?()

