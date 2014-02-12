Reactive = require('models/reactive')

describe 'Reactive', ->

  beforeEach ->
    @reactive = new Reactive



  afterEach ->
    @reactive.dispose()
