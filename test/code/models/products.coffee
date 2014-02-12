Product = require('models/product')
Products = require('models/products')

describe 'Products', ->

  beforeEach ->
    @product = new Product
    @products = new Products



  afterEach ->
    @product.dispose()
    @products.dispose()
