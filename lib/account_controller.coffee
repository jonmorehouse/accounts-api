bs = require "./bootstrap"

bs.server.get "account", (req, res, cb) ->

  req.query ?= {}
  p req.query

bs.server.post "signup", (req, res, cb) ->



