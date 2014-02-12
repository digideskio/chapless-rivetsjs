Product = require('models/product')

describe 'Product', ->

  beforeEach ->
    @product = new Product



  afterEach ->
    @product.dispose()
