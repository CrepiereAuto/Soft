'use strict'

class Recipes
  constructor: ->
    @select = @number = 4
    @ingredientsSalty = [
      {title: "{{quantity}}g de farine", quantity: 500},
      {title: "{{quantity}}l de lait", quantity: 1},
      {title: "{{quantity}} oeufs", quantity: 6},
      {title: "{{quantity}}g de beurre", quantity: 50},
      {title: "{{quantity}}g de sucre", quantity: 150}
    ]
  selector: (param, callback) ->
    switch param
      when 1
        @select++
      when -1
        if @select - 1 >= 0
          @select--
    if callback
      callback @select
  render: (callback) ->
    table = ''
    for ingredient in @ingredientsSalty
      console.log ingredient
      title = ingredient.title.replace('{{quantity}}', (ingredient.quantity*@select/@number))
      table += '<li>'+title+'</li>'
    callback(table)

module.exports = new Recipes
