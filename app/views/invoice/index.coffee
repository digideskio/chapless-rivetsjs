View = require('views/base/view')

module.exports = class InvoiceView extends View
  className: 'invoice-view'
  container: 'body'
  template: require('./template')
  events:
    'click .js-AddBtn': '_addBtnOnClick'
  listen:
    'all collection': '_updateTotal'

  initialize: ->
    # Rivets Formatter to input in dollars and store as cents
    rivets?.formatters.currency =
      read: (value) ->
        (value / Math.pow(10, 2)).toFixed(2)
      publish: (value) ->
        Math.round(parseFloat(value) * Math.pow(10, 2))

  # Chaplin method, called when View is attached
  attach: ->
    super
    rivets?.bind @$('.js-Product'), {products: @collection}

  _addBtnOnClick: (evt) ->
    @collection.add new @collection.model

  _updateTotal: (evt) ->
    @$('.js-Total').val do =>
      value = @collection.reduce (sum, product) ->
        sum + product.get('subtotal')
      , 0
      (value / Math.pow(10, 2)).toFixed(2)
