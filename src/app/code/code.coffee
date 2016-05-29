code = {
  run: false
  start: ->
    @run = true
    @loop()
  stop: ->
    @run = false
  gen: ->
    return Math.random().toString().slice(2,6)
  loop: ->
    self = @
    pin = @gen()
    iot.open(pin).then(->
      view.contents.code.key = pin
      view.update()
      setTimeout ->
        if self.run
          self.loop()
      ,10000
    ).catch(->
      if self.run
        self.loop()
    )
}

viewStart.add('code', {key: '....'})

$(document).on 'click', '.param-btn[value=code]', ->
  setTimeout ->
    code.start()
  , 2000

$(document).on 'click', '#code-return', ->
  view.contents.code.key = '....'
  code.stop()
