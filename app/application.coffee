routes = require('routes')
utils = require('lib/utils')

defaultOptions = {routes, controllerSuffix: ''}

# Create a new Chaplin Application object, which is the
# container for the entire application, and allows us to
# customize Chaplin during application initialization
module.exports = class Application extends Chaplin.Application
  title: 'Rivets' # Tell Chaplin this is the Application title

  # Customize Chaplin's Application constructor
  # to allow for the controllerSuffix to be changed
  # (i.e. allow controller files can be named differently)
  constructor: (options) ->
    super utils.extend({}, defaultOptions, options)
