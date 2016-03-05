$('#work').click ->
  view.set 0

$('.count-container').click ->
  view.set 1

events.on 'todo', ->
  $('#count').text ctr_cmd.done+'/'+ctr_cmd.todo
  $('#progress-bar').width ctr_cmd.done/ctr_cmd.todo*100+"%"
