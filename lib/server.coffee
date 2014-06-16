restify = require 'restify'
mc = require 'multi-config'
b = require "./bootstrap"
sockets = []

exports.setUp = (app, cb) ->

  # create server
  s = restify.createServer 
    name: mc.name
    version: mc.version

  # restify directives
  s.use restify.acceptParser s.acceptable
  s.use restify.queryParser mapParams: false
  s.use restify.bodyParser mapParams: true
  s.use restify.authorizationParser()
  
  # link server to application
  b.app.server = s
  require "./account_controller"

  # store all sockets for tdd help
  if mc.ENV is "test"
    s.on "connection", (socket) ->
      sockets.push socket

  # listen on server port and link up with global application
  s.listen mc.httpPort, =>
    return cb?()

exports.tearDown = (app, cb) ->

  app.server.close (err) ->
    return cb? err if err?
    cb?()

  # forcibly close all sockets, the sockets array will only have objects during env=test sessions
  [socket.destroy() for socket in sockets]


