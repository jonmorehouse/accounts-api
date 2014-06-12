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
  s.use restify.queryParser()
  s.use restify.bodyParser()
  
  b.app.server = s
  require "./account_controller"

  # store all sockets on startup
  if mc.env is "test"
    s.on "connection", (socket) ->
      sockets.push socket

  # listen on server port and link up with global application
  s.listen mc.httpPort, =>
    return cb?()


exports.tearDown = (app, cb) ->

  app.server.close (err) ->
    #return cb? err if err?
    cb?()

  # forcibly close all sockets, the sockets array will only have objects during env=test sessions
  [socket.destroy() for socket in sockets]


