viewSecu = 0
view = 0
views = {
  0: 'menu',
  1: 'cmd',
  2: 'recipes',
  3: 'params',
  4: 'work'
}

setView = (nxt) ->
  if !viewSecu
    console.log views[view]+' to '+views[nxt]
    viewSecu = 1
    $('#'+views[view]).fadeOut 'slow', ->
      $('#'+views[nxt]).fadeIn()
      view = nxt
      viewSecu = 0
