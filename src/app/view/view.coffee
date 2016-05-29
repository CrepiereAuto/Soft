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
          html = '<div id="view" data-view="'+nxt+'">'+data+'</div>'
          $('body').append(html).hide().fadeIn ->
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
  update: ->
    if !@viewSecu
      @viewSecu = 1
      self = @
      @compile @view, (data) ->
        $('#view').remove()
        html = '<div id="view" data-view="'+self.view+'">'+data+'</div>'
        $('body').append(html)
        self.viewSecu = 0
    else
      return 'error view is changing'

view = new View

viewStart.start()
# events.emit 'viewLoaded'
