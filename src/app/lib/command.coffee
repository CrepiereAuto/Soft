'use strict'

class command
  constructor: ->
    @select = 0
    @todo = 0
    @done = 0
  selector: (param, callback) ->
    switch param
      when 1
        @select++
      when -1
        if @select - 1 >= 0
          @select--
      when 0
        @todo = @select
        events.emit "update"
      when -2
        @todo = @cmd = 0
      when -3
        @select = @todo
    if callback
      callback @select

module.exports = new command
