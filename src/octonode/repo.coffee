#
# repository.coffee: Github repository class
#
# Copyright © 2011 Pavan Kumar Sunkara. All rights reserved
#

# Requiring modules

# Initiate class
class Repo

  constructor: (@name, @client) ->

  # Get a repository
  # '/repos/pkumar/hub' GET
  info: (cb) ->
    @client.get "/repos/#{@name}", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo info error")) else cb null, b

  # Get the commits for a repository
  # '/repos/pkumar/hub/commits' GET
  commits: (cb) ->
    @client.get "/repos/#{@name}/commits", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo commits error")) else cb null, b

  # Get the tags for a repository
  # '/repos/pkumar/hub/tags' GET
  tags: (cb) ->
    @client.get "/repos/#{@name}/tags", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo tags error")) else cb null, b

  # Get the languages for a repository
  # '/repos/pkumar/hub/languages' GET
  languages: (cb) ->
    @client.get "/repos/#{@name}/languages", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo languages error")) else cb null, b

  # Get the contributors for a repository
  # '/repos/pkumar/hub/contributors' GET
  contributors: (cb) ->
    @client.get "/repos/#{@name}/contributors", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo contributors error")) else cb null, b

  # Get the teams for a repository
  # '/repos/pkumar/hub/teams' GET
  teams: (cb) ->
    @client.get "/repos/#{@name}/teams", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo teams error")) else cb null, b

  # Get the branches for a repository
  # '/repos/pkumar/hub/branches' GET
  branches: (cb) ->
    @client.get "/repos/#{@name}/branches", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo branches error")) else cb null, b

  # Get the issues for a repository
  # '/repos/pkumar/hub/issues' GET
  issues: (cb) ->
    @client.get "/repos/#{@name}/issues", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo issues error")) else cb null, b

  # Get the forks for a repository
  # '/repos/pkumar/hub/forks' GET
  forks: (cb) ->
    @client.get "/repos/#{@name}/forks", (err, s, b) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Repo forks error")) else cb null, b

# Export module
module.exports = Repo
