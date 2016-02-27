class cmd
  constructor: ->
    @select = 0
    @todo = 0
    @done = 4
  selector: (param, callback) ->
    switch param
      when 1
        @select++
      when -1
        if @select - 1 >= 0
          @select--
      when 0
        @todo = @select
        events.emit "todo"
      when -2
        @todo = @cmd = 0
    if callback
      callback @select

ctr_cmd = new cmd()
