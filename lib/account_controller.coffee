{app} = require "./bootstrap"
{Account} = require "./account"

app.server.get "/account", (req, res, cb) ->

  if req.userId?
    p "do something"
  else if req.query?
    p "do something else"

  res.send key: "value"
  cb?()

#app.server.get "account", (req, res, cb) ->

  ##req.query ?= {}
  ##p req.query

app.server.post "account", (req, res, cb) ->

  p req.params
  res.send key: "value"
  cb?()



