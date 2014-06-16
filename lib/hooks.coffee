{Token} = require "./token"
{Client} = require "./client"

authenticateToken = (token, req, cb) =>

  p "authenticate token"
  cb?()

validateClient = (credentials, req, cb) =>

  p "validate client"

  cb?()

grantUserToken = (credentials, req, cb) =>

  p "grant user token"

  cb?()

module.exports =
  authenticateToken: authenticateToken
  validateClient: validateClient
  grantUserToken: grantUserToken


