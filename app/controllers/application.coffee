Controller = require('controllers/base/controller')
IndexView = require('views/index')
Reactive = require('models/reactive')
Products = require('models/products')
InvoiceView = require('views/invoice/index')

module.exports = class ApplicationController extends Controller

  # Controller's index action, referenced by router.coffee
  # In Chaplin, the model and view will automatically be
  # garbage collected when a new controller action is called
  index: ->
    @model = new Reactive # instantiate model
    @view = new IndexView {@model} # instantiate view; hydrate with model

  # Controller's invoice action, referenced by router.coffee
  invoice: ->
    @collection = new Products
    @view = new InvoiceView {@collection}
    # The above will be transcompiled to
    # the following JavaScript:
    #
    # this.view = new InvoiceView({
    #   collection: this.collection
    # });
    #
    # Backbone automatically binds collections and models
    # to Views, so they can be accessed from the view itself
    # by accessing the @collection bound attribute
