jQuery = $ = require 'jquery'
EventEmitter = require 'events'
io = require 'socket.io-client'
jsonfile = require 'jsonfile'
Handlebars = require 'handlebars'

# recipes = require './js/lib/recipes'
# ctr_cmd = require './js/lib/command'
# view = require './js/lib/view'
#
events = new EventEmitter()
# socket = io 'http://localhost:3030'
#
# bd = jsonfile.readFileSync __dirname+'/bd.json'
#
# socket.on 'connect', ->
#   console.log 'connected'
#   socket.on 'disconnect', ->
#     console.log 'disconnected'
#
#   socket.emit 'start', bd.token
#
#   if !bd.token
#     console.log 'wait token'
#     socket.on 'token', (token) ->
#       console.log token
#       bd.token = token
#       jsonfile.writeFileSync __dirname+'/bd.json', bd
#
#   events.on 'open', (code) ->
#     console.log 'station open'
#     socket.emit 'open', code
#
#   socket.on 'update', (changes) ->
#     update changes
#
# update = (changes) ->
#   for i of changes
#     change = changes[i]
#     console.log i+' = '+change
#     ctr_cmd[i] = change
#   ctr_cmd.selector -3
#   events.emit 'update'
