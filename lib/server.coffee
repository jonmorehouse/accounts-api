restify = require 'restify'
mc = require 'multi-config'

exports.setUp = (app, cb) ->

  # create server
  s = restify.createServer 
    name: mc.serverName
    version: mc.version

  # restify directives
  s.use restify.acceptParser s.acceptable
  s.use restify.queryParser()
  s.use restify.bodyParser()
  
  # require controllers
  #require "./account_controller"
  s.listen mc.httpPort, =>
    app.server = s
    return cb?()

exports.tearDown = (app, cb) ->

  app.server.close (err) ->
    return cb? err if err?
    cb?()

