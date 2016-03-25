# $('#recipes').click ->
#   view.set 0

$(".rows-recipes").click ->
  ctr_cmd.selector parseFloat($(this).attr("value")), (disp) ->
    $("#recipes-select").text disp
