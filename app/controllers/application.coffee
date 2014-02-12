Controller = require('controllers/base/controller')
IndexView = require('views/index')
Reactive = require('models/reactive')
Products = require('models/products')
InvoiceView = require('views/invoice/index')

module.exports = class ApplicationController extends Controller

  index: ->
    @model = new Reactive
    @view = new IndexView {@model}

  invoice: ->
    @collection = new Products
    @view = new InvoiceView {@collection}
