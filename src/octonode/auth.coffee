#
# auth.coffee: Authentication module for github
#
# Copyright © 2011 Pavan Kumar Sunkara. All rights reserved
#

# Requiring modules
request = require 'request'
qs = require 'querystring'

# Authentication module
auth = module.exports =

  # Authentication modes
  modes:
    cli: 0
    web: 1

  config: (options) ->
    if options.username and options.password
      @mode = @modes.cli
    else if options.id and options.secret
      @mode = @modes.web
    else
      throw new Error('No working mode recognized')
    @options = options
    return this

  login: (scopes, callback) ->
    if @mode == @modes.cli
      request
        url: "https://#{@options.username}:#{@options.password}@api.github.com/authorizations"
        method: 'POST'
        body: JSON.stringify
          "scopes": scopes
        headers:
          'Content-Type': 'application/json'
      , (err, res, body) ->
        try
          body = JSON.parse body
        catch err
          callback new Error('Unable to parse body')
        if res.statusCode is 401 then callback(new Error(body.message)) else callback(null, body.id, body.token)
    else if @mode == @modes.web
      if scopes instanceof Array
        uri = 'https://github.com/login/oauth/authorize'
        uri+= '?client_id=' + @options.id
        uri+= '&scope=' + scopes.join(',')
      else
        request
          url: 'https://github.com/login/oauth/access_token'
          method: 'POST'
          body: qs.stringify
            code: scopes
            client_id: @options.id
            client_secret: @options.secret
          headers:
            'Content-Type': 'application/x-www-form-urlencoded'
        , (err, res, body) ->
          if res.statusCode is 404
            callback(new Error('Access token not found'))
          else
            body = qs.parse body
            if body.error then callback(new Error(body.error)) else callback(null, body.access_token)
    else
      callback new Error('No working mode defined')
