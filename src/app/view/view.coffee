class View
  constructor: ->
    @viewSecu = 0
    @view = ''
    @contents = {}
  set: (nxt) ->
    if !@viewSecu
      @viewSecu = 1
      self = @
      @compile nxt, (data) ->
        display = ->
          $('body').append('<div id="view">'+data+'</div>').hide().fadeIn()
          self.view = nxt
          self.viewSecu = 0
        if $('#view').length
          $('#view').fadeOut 'slow', ->
            $(this).remove()
            display()
        else
          display()
    else
      return 'error view is changing'
  compile: (name, callback) ->
    data = @contents[name]
    $.get 'views/'+name+'.html', (file) ->
      template = Handlebars.compile(file)
      if callback then callback(template(data))
  update: (name) ->
    if !@viewSecu
      @viewSecu = 1
      self = @
      @compile name, (data) ->
        $('#view').remove()
        $('body').append('<div id="view">'+data+'</div>')
        self.viewSecu = 0
    else
      return 'error view is changing'

view = new View

events.emit 'viewLoaded'
