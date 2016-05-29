viewStart.add 'menu', {
  items: [
    {title: 'Commander', url:"img/notes.png", view:'command', active: true},
    {title: 'Recettes', url:"img/toque.png", view:'recipe'},
    {title: 'Parametres', url:"img/param.png", view:'param'}
  ]
}

$(document).on 'click', '.item', ->
  v = $('.item.active').attr 'data-view'
  if v != 'command'
    view.set v
  else if command.todo > 0
    view.set 'work'
  else
    view.set v
