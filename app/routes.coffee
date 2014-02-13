module.exports = (match) ->

  # default route, by navigating to application
  # root path (e.g. http://localhost:3333/)
  match '', 'application#index'

  # named route accessible by navigating to "/invoice" path
  # (e.g. http://localhost:3333/invoice). Tells Chaplin to
  # forward to the "invoice" action of the "application" controller
  match 'invoice', 'application#invoice'
