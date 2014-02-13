Model = require('models/base/model')

module.exports = class Product extends Model

  defaults:
    price: 0
    quantity: 1
    subtotal: 0

  # Override default Backbone method since no sync is needed
  destroy: =>
    @collection.remove @ # remove self from collection
