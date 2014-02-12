InvoiceView = require('views/invoice')

describe 'InvoiceView', ->

  beforeEach ->
    @invoiceView = new InvoiceView



  afterEach ->
    @invoiceView.dispose()
