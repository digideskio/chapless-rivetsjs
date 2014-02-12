Model = require('models/base/model')

module.exports = class Reactive extends Model

  defaults:
    name: 'One-way data binding'
    color: 'grey'
    enabled: false

  initialize: ->
    @on 'change:name', => @set 'computed', @get('name') + ' with computed property'
    window.debug = @
