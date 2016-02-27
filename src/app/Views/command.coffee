$("#col-1").click ->
  console.log $("#cmd-select").text()
  ctr_cmd.selector 0
  setView 4

$(".rows").click ->
  ctr_cmd.selector parseFloat($(this).attr("value")), (disp) ->
    $("#cmd-select").text disp

$('.cmd-return-container').click ->
  setView 0
