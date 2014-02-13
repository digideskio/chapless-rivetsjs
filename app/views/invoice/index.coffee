View = require('views/base/view') # Pull in the base view method for inheritance

module.exports = class InvoiceView extends View # Inherit from base view and export module
  className: 'invoice-view'
  container: 'body'
  template: require('./template') # Pull in the templating function
  events:
    'click .js-AddBtn': '_addBtnOnClick'

  # When a model (or collection) is bound to the view upon View
  # instantiation, Chaplin's listen hash allows us to easily
  # listen for events without creating our own event listeners
  listen:
    'all collection': '_updateTotal'

  initialize: ->

    # Create Rivets Formatter to input in dollars and store without decimal
    # This should actually be defined in "view-helper.coffee" so it can be
    # used more DRYly
    rivets?.formatters.currency =
      read: (value) ->
        (value / Math.pow(10, 2)).toFixed(2)
      publish: (value) ->
        Math.round(parseFloat(value) * Math.pow(10, 2))

  # Attach is a Chaplin method that is called when the View's template
  # is inserted into the DOM
  attach: ->
    super # calls attach method in base view first
    rivets?.bind @$('.js-Product'), {products: @collection} # binds collection to template

  # Create a private event handler function on this object's prototype
  # Pass in evt as an argument as a best practice, even though it's not used
  _addBtnOnClick: (evt) ->
    @collection.add new @collection.model # instantiate and add new model to collection

  _updateTotal: (evt) ->

    # Set the total value calling the collection's reduce method, made
    # available to Backbone by use of Underscore (or, in this case, Lo-Dash)
    @$('.js-Total').val do =>
      value = @collection.reduce (sum, product) ->
        sum + product.get('subtotal')
      , 0
      (value / Math.pow(10, 2)).toFixed(2) # CoffeeScript returns the last line automatically
