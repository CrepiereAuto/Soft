$('#work').click ->
  setView 0

$('.count-container').click ->
  setView 1

events.on 'todo', ->
  $('h5').text ctr_cmd.done+'/'+ctr_cmd.todo
  $('#progress-bar').width ctr_cmd.done/ctr_cmd.todo*100+"%"
