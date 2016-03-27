$("#col-1").click ->
  slct = $("#cmd-select").text()
  ctr_cmd.selector 0
  if slct > 0
    view.set 4

$(".rows").click ->
  ctr_cmd.selector parseFloat($(this).attr("value")), (disp) ->
    $("#cmd-select").text disp

$('.cmd-return-container').click ->
  view.set 0
