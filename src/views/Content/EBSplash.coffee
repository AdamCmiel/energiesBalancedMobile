EBView = require "../EBView"
Surface = require "famous/core/Surface"
ImageSurface = require "famous/surfaces/ImageSurface"
RenderController = require "famous/views/RenderController"
Transform = require "famous/core/Transform"
Transitionable = require "famous/transitions/Transitionable"
Modifier = require "famous/core/Modifier"
Timer = require "famous/utilities/Timer"
Easing = require "famous/transitions/Easing"
pi = Math.PI

class EBSplash extends EBView
  constructor: ->
    super

    background = new Surface @options.background
    @add background

    content = @content = new RenderController @options.renderController
    logoSurface = new ImageSurface @options.logo
    logoTranslationModifier = new Modifier
      # origin: [0.5, 0.5]
    logoRotationModifier = new Modifier
      origin: [0.5, 0.5]
    progress = @progress = new Transitionable 0

    logoTranslationModifier.sizeFrom ->
      p = progress.get()
      s = 150 * (1-p) + 40
      [s, s]

    logoTranslationModifier.transformFrom ->
      p = progress.get()
      s = 150 * (1-p) + 40
      x = (0.5 * window.innerWidth) * (1 - Math.sin(5 * p / pi)) - 0.5 * s * (1-p) + p * 8
      y = (0.5 * window.innerHeight - 0.5 * s) * (1-p) + p * 8
      a = 2 * pi * p
      Transform.translate x, y, 0

    logoRotationModifier.transformFrom ->
      p = progress.get()
      Transform.rotateZ (3 * p - 1) * pi

    logo = @logo = @add logoTranslationModifier
                   .add logoRotationModifier
                   .add logoSurface

    labelContent = @labelContent = new RenderController @options.renderController
    labelSurface = new ImageSurface @options.label
    labelTranslationModifier = new Modifier
      size: [300, 40]
      origin: [0.5, 0.7]

    labelTranslationModifier.transformFrom ->
      p = progress.get()
      y = p * 300
      Transform.translate 0, y, 0

    label = @label = @add labelTranslationModifier
                     .add labelSurface

  start: ->
    @content.show @logo
    @labelContent.show @label
    Timer.after (=> @move()), 5

  move: ->
    @progress.set 1, @options.inBackMoveTransition, => @end()

  end: ->
    @_eventOutput.emit "splashPageComplete"

EBSplash.DEFAULT_OPTIONS =
  background: classes: ["splash-page-background"]
  logo: content: "images/eb_logo_transparent.svg"
  label: content: "images/eb_logo_label.jpg"
  renderController:
    inTransition:
      duration: 0
    outTransition:
      duration: 0
  springMoveTransition:
    duration: 4000
    method: "spring"
    period: 800
    dampingRatio: 0.7
  inBackMoveTransition:
    curve: (t) -> Easing.inOutBack t, 0.7
    duration: 2000

module.exports = EBSplash