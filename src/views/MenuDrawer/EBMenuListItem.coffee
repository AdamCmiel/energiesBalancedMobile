EBView = require "../EBView"
EBButton = require "../EBButton"
EBButtonLabel = require "../../templates/EBMenuListItem.jade"
Modifier = require "famous/core/Modifier"
Transform = require "famous/core/Transform"
router = require "../../EBRouter"

class EBMenuListItem extends EBView
  constructor: (options) ->
    super

    page = options.page
    title = options.title
    position = options.position

    button = new EBButton
      content: EBButtonLabel title: title, position: position
      classes: ["eb-button", "menu-list-item"]
      eventName: "menu-list-item-clicked"

    @subscribe button
    button.on "menu-list-item-clicked", ->
      router.navigate title
      @_eventOutput.emit "closeMenu"

    buttonModifier = new Modifier
      size: [undefined, 80]
      transform: Transform.translate 0, 100 * position, 0

    @add buttonModifier
    .add button

module.exports = EBMenuListItem