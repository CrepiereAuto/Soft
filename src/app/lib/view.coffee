views = {
  0: 'menu',
  1: 'cmd',
  2: 'recipes',
  3: 'params',
  4: 'work'
}

class view
  constructor: ->
    @viewSecu = 0
    @view = 0
  set: (nxt) ->
    if !@viewSecu
      console.log views[@view]+' to '+views[nxt]
      @viewSecu = 1
      self = @
      $('#'+views[@view]).fadeOut 'slow', ->
        $('#'+views[nxt]).fadeIn()
        self.view = nxt
        self.viewSecu = 0

module.exports = new view
