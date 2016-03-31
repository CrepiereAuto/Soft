class View
  constructor: ->
    @viewSecu = 0
    @view = ''
    @contents = {}
    self = @
    $('#view').on 'click', '.item', ->
      self.set $('.item.active').attr 'data-view'
  set: (nxt) ->
    if !@viewSecu
      # @viewSecu = 1
      self = @
      @compile nxt, (data) ->
        display = ->
          $('#view').append(data).hide().fadeIn()
          self.view = nxt
          self.viewSecu = 0
        if $('#view').children().length
          $('#view').children().fadeOut 'slow', ->
            $(this).remove()
            display()
        else
          display()
  compile: (name, callback) ->
    data = @contents[name]
    $.get 'views/'+name+'.html', (file) ->
      template = Handlebars.compile(file)
      if callback then callback(template(data))

view = new View

view.contents = {
  menu: {
    items: [
      {title: 'Commander', url:"img/notes.png", view:'command', active: true},
      {title: 'Recettes', url:"img/toque.png", view:'recipe'},
      {title: 'Parametres', url:"img/param.png", view:'params'}
    ]
  }
}

view.set 'menu'
