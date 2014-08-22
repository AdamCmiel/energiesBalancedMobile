Surface            = require 'famous/core/Surface'
HeaderFooterLayout = require 'famous/views/HeaderFooterLayout'
RenderController   = require 'famous/views/RenderController'

EBView             = require './EBView'
EBHeader           = require './Header/EBHeader'
EBSplash           = require './content/EBSplash'
EBInstagramList    = require './content/EBInstagramList'
EBClassList        = require './content/EBClassList'
EBTeachersList     = require './content/EBTeachersList'
EBPodcastFeed      = require './content/EBPodcastFeed'
EBMassagePage      = require './content/EBMassagePage'
router             = require '../EBRouter'

class EBContentView extends EBView
  constructor: ->
    super

    @pages = {}

    # change this to consume pages.json, how to use constructors?
    @addPage
      page: "splash"
      renderable: new EBSplash
      title: "Energies Balanced"

    @addPage
      page: "ig-feed"
      renderable: new EBInstagramList
      title: "Energies Balanced"

    @addPage
      page: "classes"
      renderable: new EBClassList
      title: "Yoga Classes"

    @addPage
      page: "teachers"
      renderable: new EBTeachersList
      title: "Instructors"

    @addPage
      page: "massage"
      renderable: new EBMassagePage
      title: "Massage"

    layoutRenderController = @layoutRenderController = new RenderController @options.layoutRenderController

    layout = @layout = new HeaderFooterLayout @options.layout
    layout.header    = header = @header = new EBHeader
    layout.content   = content = @content = new RenderController @options.renderController

    @add layoutRenderController
    layoutRenderController.show layout

    # Rebroadcast touch events to DrawerLayout
    @subscribe header
    @pipeThroughTouchEvents()
    @pipeThrough "toggleMenu"

  addPage: (pageObj) ->
    @pages[pageObj.page] = pageObj
    @subscribe pageObj.renderable

  showPage: (page) ->
    if page == "splash"
      @showSplashPage()
      return

    log "Showing page: #{page}"
    @header.setHeader @pages[page].title
    @content.show @pages[page].renderable

  showSplashPage: ->
    @layoutRenderController.show @pages["splash"].renderable
    @pages["splash"].renderable.start()

    @_eventInput.on "splashPageComplete", =>
      @layoutRenderController.show @layout
      router.navigate "ig-feed", duration: 0

EBContentView.DEFAULT_OPTIONS =
  layout:
    headerSize: 60
    footerSize: 0
  renderController:
    inTransition:
      duration: 0
    outTransition:
      duration: 0
  layoutRenderController:
    inTransition:
      duration: 0
    outTransition:
      duration: 500


module.exports = EBContentView
