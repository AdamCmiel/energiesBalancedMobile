EBView = require './EBView'
Surface = require 'famous/core/Surface'
DrawerLayout = require '../famousInternal/DrawerLayout'
TouchSync = require 'famous/inputs/TouchSync'
EBMenu = require './MenuDrawer/EBMenu'
EBContentView = require './EBContentView'
router = require '../EBRouter'
pages = require '../pages'

###*
 * Top Level App Controller
 * @class App
 * @extends EBView
###
class App extends EBView
  constructor: ->
    super
    layout = @layout = new DrawerLayout @options.layout
    layout.drawer = drawer = new EBMenu
    layout.content = content = @content = new EBContentView

    sync = new TouchSync @options.sync

    content.pipe sync
    sync.pipe layout

    @add layout

    @subscribe content
    @subscribe drawer
    @_eventInput.on 'toggleMenu', =>
      layout.toggle @options.layout.transition

    # Make this more elegant
    router.on "route:splash", => @showPage "splash"
    router.on "route:ig-feed", => @showPage "ig-feed"
    router.on "route:classes", => @showPage "classes"
    router.on "route:teachers", => @showPage "teachers"
    router.on "route:podcast-feed", => @showPage "podcast-feed"
    router.on "route:massage", => @showPage "massage"

    router.navigate "ig-feed"

    # for page of pages
    #   log "Attaching route listener at route:#{page}"
    #   router.on "route:#{page}", =>
    #     @showPage page
    #     log "Route:#{page}"

  showPage: (page) ->
    log "Showing page #{page}"
    @content.showPage page
    @layout.close()

App.DEFAULT_OPTIONS =
  layout:
    drawerLength: 260
    positionThreshold: 180
    velocityThreshold: 0.1
    transition:
      method: "spring"
      period: 450
      dampingRatio: 0.6
  sync:
    direction: TouchSync.DIRECTION_X

###*
 * @exports App
###
module.exports = App
