'use strict'

class Recipes
  constructor: ->
    @select = @number = 4
    farine = new Ingredient 'de farine', {
      item: 500,
      init: @number,
      select: @select
    }
    @ingredientsSalty = [
      new Ingredient 'de farine', {
        item: 500,
        init: @number,
        select: @select
      }
    ]

    # @ingredientsSalty = [
    #   {
    #     sentence: "de farine",
    #     quantity: 500
    #   },
    #   {sentence: "de lait", quantity: 1},
    #   {sentence: "oeufs", quantity: 6},
    #   {sentence: "de beurre", quantity: 50},
    #   {sentence: "de sucre", quantity: 150}
    # ]
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
    ingredientsSalty = [
      new Ingredient('de farine', {
        item: 500,
        init: @number,
        select: @select
      }, 'g'),
      new Ingredient('de lait', {
        item: 1,
        init: @number,
        select: @select
      }, 'L')
    ]
    for ingredient in ingredientsSalty
      data = ingredient
      table += handlebars("<li>{{quantity}}{{unity}} {{sentence}}</li>", data)
    callback(table)

handlebars = (source, data) ->
  names = []
  result = source
  bars = {
    open: getIndicesOf('{{', source),
    close: getIndicesOf('}}', source)
  }
  for i of bars.open
    names.push source.substring bars.open[i]+2, bars.close[i]
  for name in names
    if data[name]
      if data[name] instanceof Function
        result = result.replace '{{'+name+'}}', data[name]()
      else
        result = result.replace '{{'+name+'}}', data[name]

    else
      result = result.replace '{{'+name+'}}', ''
  return result

getIndicesOf = (searchStr, str, caseSensitive) ->
  startIndex = 0
  searchStrLen = searchStr.length
  index = null
  indices = []
  while ((index = str.indexOf(searchStr, startIndex)) > -1)
    indices.push(index)
    startIndex = index + searchStrLen
  return indices

Ingredient = (sentence, quantity, unity) ->
  return {
    sentence: sentence,
    quantity: ->
      return quantity.item*quantity.select/quantity.init
    unity: unity
  }

module.exports = new Recipes
