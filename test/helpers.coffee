t = require 'test-bootstrap'
ch = require 'charlatan'

_getKw = ->
    username: ch.Internet.userName()
    emailAddress: ch.Internet.freeEmail()
    password: ch.Internet.password 10

{Account} = libRequire "account"
{Client} = libRequire "client"
#{Token} = libRequire "token"

exports.createAccount = (cb) =>
  Account.create _getKw(), (err, account) =>
    cb? account

exports.createToken = (cb) =>
  cb?()

exports.createClient = (cb) =>
  Client.create (err, client) =>
    cb? client


