Surface = require 'famous/core/Surface'
EBView = require '../EBView'
HeaderFooterLayout = require 'famous/views/HeaderFooterLayout'
EBHeaderLogo = require './EBHeaderLogo'

class EBHeader extends EBView
  constructor: ->
    super

    #Add background surface
    background = new Surface @options.background
    @subscribe background
    @add background

    #Add header footer layout for header icon nav
    layout = new HeaderFooterLayout @options.layout
    @add layout

    #Add logo button to reveal drawer
    layout.header = logo = new EBHeaderLogo
    @subscribe logo

    layout.content = @headerLabel = new Surface @options.label
    @subscribe @headerLabel

    @pipeThroughTouchEvents()
    @pipeThrough "toggleMenu"

EBHeader.DEFAULT_OPTIONS =
  background:
    properties:
      backgroundColor: 'black'
  label:
    content: 'Energies Balanced'
    properties:
      color: 'white'
  layout:
    direction: HeaderFooterLayout.DIRECTION_X
    headerSize: 60,
    footerSize: 60

EBHeader::setTitle = (title) ->
  @headerLabel.setContent title

module.exports = EBHeader