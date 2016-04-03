class Command
  constructor: (args) ->
    @select = 0
    @todo = 0
    @done = 1

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
      view.contents.work.percent =  Math.round(@done*100/@todo)
      view.set 'work'

  done: ->
    console.log 'done'


command = new Command

viewStart.add 'command', {
  select: command.select
}

$(document).on 'click', '.command-rows', ->
  command.selector parseFloat($(this).attr("value"))

$(document).on 'click', '#col-1', ->
  command.validate()
