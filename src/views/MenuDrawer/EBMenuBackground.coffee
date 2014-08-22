View = require "famous/core/View"
Modifier = require "famous/core/Modifier"
Transform = require "famous/core/Transform"
ImageSurface = require "famous/surfaces/ImageSurface"

class EBMenuBackground extends View
  constructor: ->
    super
    background = new ImageSurface
      content: "images/menu_background.svg"
    backgroundModifier = new Modifier
      origin: [0.5, 0.5]
      align: [0.5, 0.5]
      size: [window.innerWidth * 1.1, window.innerHeight * 1.1]
      transform: Transform.translate -10, -5, -2
    @add backgroundModifier
    .add background

module.exports = EBMenuBackground