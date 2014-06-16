t = require 'test-bootstrap'
ch = require 'charlatan'
extend = require 'extend'
{Account} = libRequire "account"
{Client} = libRequire "client"
{Token} = libRequire "token"

_getKw = ->
    username: ch.Internet.userName()
    emailAddress: ch.Internet.freeEmail()
    password: ch.Internet.password 10

exports.createAccount = (cb) =>
  kw = _getKw()
  Account.create kw, (err, account) =>
    p err
    account.password = kw.password
    cb? account

exports.createToken = (cb) =>
  cb?()

exports.createClient = (cb) =>
  Client.create (err, client) =>
    cb? client

exports.tokenRequestKw = (cb) =>
  exports.createAccount (account) ->
    exports.createClient (client) ->
      test = extend true, account, client
      cb? extend(true, account, client)

