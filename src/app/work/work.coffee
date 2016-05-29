viewStart.add 'work', {
  timer: '15:12',
  percent: 60,
  done: 5,
  todo: 10
}

$(document).on 'click', '.work-count', ->
  view.set 'command'

$(document).on 'click', '#view[data-view="work"]', ->
  view.set 'menu'
