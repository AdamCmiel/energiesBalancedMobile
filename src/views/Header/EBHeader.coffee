Surface = require 'famous/core/Surface'
Modifier = require 'famous/core/Modifier'
EBView = require '../EBView'
HeaderFooterLayout = require 'famous/views/HeaderFooterLayout'
EBHeaderLogo = require './EBHeaderLogo'
EBHeaderLabel = require '../../templates/EBHeaderLabel.jade'
Transform = require 'famous/core/Transform'

class EBHeader extends EBView
  constructor: ->
    super

    addNode = @add new Modifier transform: Transform.translate 0, 0, 10

    #Add background surface
    background = new Surface @options.background
    @subscribe background
    addNode.add background

    #Add header footer layout for header icon nav
    layout = new HeaderFooterLayout @options.layout
    layoutZModifier = new Modifier transform: Transform.inFront
    addNode.add layoutZModifier
           .add layout

    #Add logo button to reveal drawer
    layout.header = logo = new EBHeaderLogo
    @subscribe logo

    layout.content = @headerLabel = new Surface @options.label
    @subscribe @headerLabel

    @pipeThroughTouchEvents()
    @pipeThrough "toggleMenu"

  setHeader: (content) ->
    @headerLabel.setContent EBHeaderLabel content: content

EBHeader.DEFAULT_OPTIONS =
  background:
    classes: ["header-background"]
  label:
    content: EBHeaderLabel content: "Energies Balanced"
  layout:
    direction: HeaderFooterLayout.DIRECTION_X
    headerSize: 60,
    footerSize: 60

EBHeader::setTitle = (title) ->
  @headerLabel.setContent title

module.exports = EBHeader
