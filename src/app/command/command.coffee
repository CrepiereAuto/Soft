class Command
  constructor: (args) ->
    @select = 0
    @todo = 0
    @done = 0

  progress: ->
    return Math.round(@done*100/@todo)

  set: (todo) ->
    @todo = @select = parseInt todo
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
    @todo = @select
    if @select
      view.contents.work.todo = @todo
      view.contents.work.done = @done
      view.contents.work.percent = @progress()
      view.set 'work'
      iot.send 'command', {todo: @todo, done: @done, progress: @progress(), room: room}

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
      iot.send 'command', {todo: @todo, done: @done, progress: @progress(), room: room}
      return true

command = new Command

viewStart.add 'command', {
  select: command.select
}

$(document).on 'click', '.command-rows', ->
  command.selector parseFloat($(this).attr("value"))

$(document).on 'click', '#col-1', ->
  command.validate()
