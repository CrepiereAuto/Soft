# $('#recipes').click ->
#   view.set 0
$("#recipes-select").text recipes.select
recipes.render (table) ->
  $('#liste-salée').empty()
  $('#liste-salée').append table
$(".rows-recipes").click ->
  recipes.selector parseFloat($(this).attr("value")), (disp) ->
    $("#recipes-select").text disp
    recipes.render (table) ->
      $('#liste-salée').empty()
      $('#liste-salée').append table
