{app} = require "./bootstrap"

app.server.get "/", (req, res, cb) ->

  cb?()

app.server.get "account", (req, res, cb) ->

  #req.query ?= {}
  #p req.query

app.server.post "signup", (req, res, cb) ->



