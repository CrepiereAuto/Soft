$('.item').click ->
  menu = $('ol li.active').attr 'data-slide-to'
  menu++
  view.set menu
