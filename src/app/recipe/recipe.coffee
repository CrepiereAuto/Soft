class Recipe
  constructor: ->
    param = ->
      @persons = 4
      @salty = [
        {sentence: "de farine", quantity: 500, unity: 'g'},
        {sentence: "d'eau", quantity: 1, unity: 'L'},
        {sentence: "oeufs", quantity: 4, unity: ''},
        {sentence: "de beurre", quantity: 50, unity: 'g'}
      ]
      @sugary = [
        {sentence: "de farine", quantity: 500, unity: 'g'},
        {sentence: "de lait", quantity: 1, unity: 'L'},
        {sentence: "oeufs", quantity: 6, unity: ''},
        {sentence: "de beurre", quantity: 50, unity: 'g'},
        {sentence: "de sucre", quantity: 150, unity: 'g'}
      ]
      return @
    @init = new param
    @recipe = new param

  selector: (param) ->
    switch param
      when 1
        @recipe.persons++
        @render()
      when -1
        if @recipe.persons - 1 >= 1
          @recipe.persons--
          @render()
  render: ->
    for y in ['salty', 'sugary']
      for i of @recipe[y]
        quantity = @init[y][i].quantity*@recipe.persons/@init.persons
        if @recipe[y][i].sentence == "oeufs"
          quantity = Math.round(quantity)
        else
          quantity = Math.round(quantity*100)/100
        @recipe[y][i].quantity = quantity
    view.contents.recipe = @recipe
    view.update()

recipe = new Recipe

viewStart.add 'recipe', recipe.init

$(document).on 'click', '.recipe-selector-row', ->
  recipe.selector parseFloat $(this).attr('value')
