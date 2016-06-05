'use strict'
jQuery = $ = require 'jquery'
EventEmitter = require 'events'
io = require 'socket.io-client'
jsonfile = require 'jsonfile'
Handlebars = require 'handlebars'
fs = require 'fs'
request = require 'request'
gpio = require 'gpio'
IOT = require('socket.io-iot').default

events = new EventEmitter()

serverUrl = '81.240.88.61:3030'

# if !fs.existsSync __dirname+'/bd.json'
#   fs.writeFileSync __dirname+'/bd.json', "{}"
# bd = jsonfile.readFileSync __dirname+'/bd.json'

iot = new IOT serverUrl, 'server'

room = null

iot.on 'connect', (msg) ->
  console.log 'connected'
  room = msg.room

iot.on 'id', (id) ->
  # jsonfile.writeFileSync __dirname+'/bd.json', {id: id}

iot.on 'get', ->
  iot.send 'command', {todo: command.todo, done: command.done, progress: command.progress(), room: room}

iot.on 'command', (d) ->
  command.set d.todo

# commands = [{todo: 2, done:1}, {todo: 5, done: 0}]
#
# setCommand = (n) ->
#   if commands[0]
#     commands[0].todo = n
#   else
#     commands.push {todo: n, done: 0}
#   renderCommand()
#
# renderCommand = ->
#   view.contents.work = {
#     timer: '15:12',
#     percent: Math.round(commands[0].done*100/commands[0].todo),
#     done: commands[0].done,
#     todo: commands[0].todo
#   }
#   if view.view == 'work'
#     view.update()
#
# addDone = ->
#   commands[0].done = commands[0].done + 1
#   renderCommand()
#   if commands[0].done == commands[0].todo
#     commands.splice(0,1)
#     if commands[0]
#       command.set(commands[0].todo)
#       renderCommand()
#     else
#       command.set(0)
#   console.log commands

viewStart = {
  started: 0,
  contents: {},
  add: (name, params) ->
    if @started
      view.contents[name] = params
    else
      @contents[name] = params
  start: ->
    @started = 1
    view.contents = @contents
    view.set 'menu'
}

fs.existsSync = (filePath) ->
  try
    fs.statSync filePath
  catch error
    if error.code == 'ENOENT'
      return false
  return true

update = (changes) ->
  for i of changes
    change = changes[i]
    console.log i+' = '+change
    ctr_cmd[i] = change
  ctr_cmd.selector -3
  events.emit 'update'
