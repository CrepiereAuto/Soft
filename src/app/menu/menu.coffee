viewStart.add 'menu', {
  items: [
    {title: 'Commander', url:"img/notes.png", view:'command', active: true},
    {title: 'Recettes', url:"img/toque.png", view:'recipe'},
    {title: 'Parametres', url:"img/param.png", view:'param'}
  ]
}

$(document).on 'click', '.item', ->
  view.set $('.item.active').attr 'data-view'
