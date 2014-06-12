restify = require 'restify'
mc = require 'multi-config'

exports.setUp = (app, cb) ->

  return cb?()

  # create server
  s = restify.createServer 
    name: mc.serverName
    version: mc.version

  # restify directives
  s.use restify.acceptParser s.acceptable
  s.use restify.queryParser()
  s.use restify.bodyParser()
  
  # require controllers

exports.tearDown = (app, cb) ->

  return cb?()

