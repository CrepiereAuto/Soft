jQuery = $ = require 'jquery'
EventEmitter = require 'events'
# express = require 'express'
# http = require 'http'
# io = require 'socket.io'
#
ctr_cmd = require './js/lib/command'
view = require './js/lib/view'

events = new EventEmitter()
#
# app = express()
# http = http.Server app
# io = io http
#
# app.get '/', (req, res) ->
#   res.send '<h1>Hello world</h1>'
#
# io.on 'connection', (socket) ->
#   console.log 'a user connected'
#
# http.listen 1024, ->
#   console.log 'listening on *:3000'
#
# io = require 'socket.io-client'
# socket = io 'http://localhost:3030'
#
# users = []
#
#
# socket.on 'connect', ->
#   console.log 'connected'
#   socket.on 'disconnect', ->
#     console.log 'disconnected'
#
#   socket.emit 'start'
#
#   socket.on 'token', (token) ->
#     console.log token
#     socket.emit 'open', '123'
