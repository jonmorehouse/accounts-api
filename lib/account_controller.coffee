{app} = require "./bootstrap"
{Account} = require "./account"

app.server.get "/account", (req, res, cb) ->

  if req.userId?
    true
  else if req.query?
    true

  res.send key: "value"
  cb?()

app.server.post "/account", (req, res, cb) ->

  Account.create req.params, (err, acc) ->

    if err? or not acc?
      res.send 400, err if err? 
    else
      res.send 201, acc

    res.end()
    cb?()



