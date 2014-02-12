Model = require('models/base/model')

module.exports = class Product extends Model

  defaults:
    price: 0
    quantity: 1
    subtotal: 0

  initialize: ->
    @on 'change:price change:quantity', @setSubtotal
    @on 'change:item', @setPrice

  # Override default Backbone method since no sync is needed
  destroy: =>
    @collection.remove @
