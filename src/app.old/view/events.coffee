events.on 'update', ->
  progress = Math.round(ctr_cmd.done/ctr_cmd.todo*100)+"%"
  $('#count').text ctr_cmd.done+'/'+ctr_cmd.todo
  $('#progress-bar').width progress
  $('#progress-bar > span').text progress
  $("#cmd-select").text ctr_cmd.select
