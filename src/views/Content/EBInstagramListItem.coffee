EBView = require '../EBView'
Modifier = require 'famous/core/Modifier'
ImageSurface = require 'famous/surfaces/ImageSurface'
Surface = require 'famous/core/Surface'
Transform = require 'famous/core/Transform'

class EBInstagramListItem extends EBView
  constructor: (imageURL) ->
    super
    content = new ImageSurface content: imageURL
    cardBackground = new Surface @options.background
    cardBackgroundModifier = new Modifier
      origin: [0.5, 0]
      transform: Transform.translate 0, -2.5, 1
      size: [window.innerWidth - 15,
             window.innerWidth - 15]
    @contentModifier = new Modifier
      origin: [0.5, 0]
      transform: Transform.translate 0, 0, 2
      size: [window.innerWidth - 20
             window.innerWidth - 20]

    @subscribe content
    @pipeThroughTouchEvents()
    @add @contentModifier
    .add content
    @add cardBackgroundModifier
    .add cardBackground

EBInstagramListItem.DEFAULT_OPTIONS =
  background:
    classes: ["instagram-list-item-card-background"]

EBInstagramListItem::getSize = ->
    imageSize = @contentModifier.getSize()
    [imageSize[0] + 10, imageSize[1] + 12.5]

module.exports = EBInstagramListItem