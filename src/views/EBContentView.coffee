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

class EBContentView extends EBView
  constructor: ->
    super

    @pages =
      "splash":       new EBSplash
      "ig-feed":      new EBInstagramList
      "classes":      new EBClassList
      "teachers":     new EBTeachersList
      "podcast-feed": new EBPodcastFeed
      "massage":      new EBMassagePage

    layout         = new HeaderFooterLayout @options.layout
    layout.header  = header = new EBHeader
    layout.content = content = @content = new RenderController @options.renderController

    instagramList = new EBInstagramList
    content.show instagramList
    @add layout

    # Rebroadcast touch events to DrawerLayout
    @subscribe header
    @pipeThroughTouchEvents()
    @pipeThrough "toggleMenu"

EBContentView.DEFAULT_OPTIONS =
  layout:
    headerSize: 60
    footerSize: 0
  renderController: {}

EBContentView::showPage = (page) ->
    @content.show @pages[page].renderable

module.exports = EBContentView
