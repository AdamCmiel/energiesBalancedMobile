EBButton = require '../EBButton'
Transform = require 'famous/core/Transform'
Surface = require 'famous/core/Surface'
Modifier = require 'famous/core/Modifier'

class EBHeaderLogo extends EBButton
  constructor: ->
    super

    @content.setContent 'images/eb_logo_transparent.svg'
    @contentModifier.setTransform Transform.translate(0, 0, 2)
    @subscribe @content
    @pipeThroughTouchEvents()

    initialTime = Date.now()
    spinningWhiteThing = new Surface @options.background
    spinner = new Modifier
      opacity: 0.8
      size: [60, 60]
      origin: [0.5, 0.5]
      # transform: ->
      #   Transform.rotateZ 0.0005 * (Date.now() - initialTime)

    @add spinner
    .add spinningWhiteThing

EBHeaderLogo.DEFAULT_OPTIONS =
  ImageSurface: yes
  classes: ['header-logo']
  eventName: 'toggleMenu'
  background:
    classes: ['header-logo-background']

module.exports = EBHeaderLogo