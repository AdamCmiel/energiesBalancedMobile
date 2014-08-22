EBView = require "../EBView"
Modifier = require "famous/core/Modifier"
EBMenuBackground = require "./EBMenuBackground"
EBMenuList = require "./EBMenuList"

class EBMenu extends EBView
  constructor: ->
    super

    menu = new EBMenuList
    @subscribe menu
    @add menu

    @pipeThrough "closeMenu"

    # Add Background
    background = new EBMenuBackground
    @add background

module.exports = EBMenu