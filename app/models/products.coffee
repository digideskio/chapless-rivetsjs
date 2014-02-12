Collection = require('models/base/collection')
Product = require('./product')

module.exports = class Products extends Collection
  model: Product

  initialize: ->
    @on 'change', @_calculateTotals
    @add [
      {price: 0, quantity: 1, subtotal: 0}
      {price: 0, quantity: 1, subtotal: 0}
    ]
    window.debug = @

  _calculateTotals: (product) ->
    product.set 'subtotal', 1 * product.get('quantity') * 1 * product.get('price')
    @total = @reduce (sum, product) ->
      sum + product.get('subtotal')
    , 0
