Backbone = require "backbone"
$ = require "jquery"
Backbone.$ = $
pages = require "./pages"

class EBRouter extends Backbone.Router

  constructor: ->
    super

    Backbone.history.start()
    log "Backbone history started"

    for page of pages
      log "Attaching route at route:#{page}"
      @route page, page

    log "Router created"

  navigate: (path) -> super path, trigger: true

  routes:
    "": "splash"

module.exports = router = new EBRouter
