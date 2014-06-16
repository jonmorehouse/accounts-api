{app} = require "./bootstrap"
{Account} = require "./account"

app.server.get "/account", (req, res, cb) ->

  if not req.query? and req.userId?
    return cb new Error "Unauthenticated user"

  # generate args to pass and find the account
  args = if (key for key of req.query).length > 0 then req.query else {id: req.userId}

  # grab the account
  Account.find args, (err, acc) ->
    
    if err? then res.send 400, err
    else
      res.send 200, acc
    # call next step in server
    cb?()

app.server.post "/account", (req, res, cb) ->

  Account.create req.params, (err, acc) ->

    if err? or not acc?
      res.send 400, err if err? 
    else
      res.send 201, acc

    res.end()
    cb?()



