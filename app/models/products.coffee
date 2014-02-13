Collection = require('models/base/collection') # Base collection extends Chaplin.Collection
Product = require('./product') # Relative path to help ensure model moves with collection

module.exports = class Products extends Collection
  model: Product # Specify model for this collection

  initialize: ->

    # Calculate totals when any of this collection's models change
    @on 'change', @_calculateTotals

    # Call this collection's add method and add two models
    @add [
      {price: 0, quantity: 1, subtotal: 0}
      {price: 0, quantity: 1, subtotal: 0}
    ]

  _calculateTotals: (product) ->

    # Set model's subtotal as product of quantity and price
    product.set 'subtotal', product.get('quantity') * product.get('price')
