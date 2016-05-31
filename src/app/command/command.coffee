class Command
  constructor: (args) ->
    self = @
    @select = 0
    @todo = 0
    @done = 0
    @arduino = {
      in: gpio.export(16, {
          direction: 'in'
        }),
      out: gpio.export(26, {
          direction: 'out',
          ready: ->
            self.arduino.out.set(0)
        })
    }
    @arduino.in.on 'change', (v) ->
      if v
        console.log 'start'
      else
        console.log 'stop'
        sefl.arduino.out.set(0)
        self.addDone()

  progress: ->
    return Math.round(@done*100/@todo)

  set: (todo) ->
    todo = parseInt todo
    if @todo == 0 && todo > 0
      @make()
    @todo = @select = todo
    view.contents.work.todo = @todo
    view.contents.work.done = @done
    view.contents.work.percent = @progress()
    view.contents.command.select = @select
    iot.send 'command', {todo: @todo, done: @done, progress: @progress(), room: room}
    view.update()

  selector: (param) ->
    switch param
      when 1
        @select++
      when -1
        if @select - 1 >= 0
          @select--
    view.contents.command = {
      select: @select
    }
    view.update()

  validate: ->
    if @select
      view.set 'work'
      @set @select

  addDone: ->
    if @done + 1 <= @todo
      @done++
      view.contents.work.todo = @todo
      view.contents.work.done = @done
      view.contents.work.percent = @progress()
      if view.view == 'work'
        view.update()
      if @done == @todo
        console.log 'o'
        self = @
        setTimeout ->
          console.log 'k'
          self.select = 0
          self.todo = 0
          self.done = 0
          view.contents.work.todo = self.todo
          view.contents.work.done = self.done
          view.contents.work.percent =  0
          view.contents.command = {
            select: self.select
          }
          view.set 'menu'
        , 2000
      else
        @make()
      iot.send 'command', {todo: @todo, done: @done, progress: @progress(), room: room}
      return true

  make: ->
    console.log "ok"
    @arduino.out.set()

command = new Command

viewStart.add 'command', {
  select: command.select
}

$(document).on 'click', '.command-rows', ->
  command.selector parseFloat($(this).attr("value"))

$(document).on 'click', '#col-1', ->
  command.validate()
