EBView = require '../EBView'
Modifier = require 'famous/core/Modifier'
EBMenuBackground = require './EBMenuBackground'
EBMenuList = require './EBMenuList'

class EBMenu extends EBView
  constructor: ->
    super

    menu = new EBMenuList
    @add menu

    # Add Background
    background = new EBMenuBackground
    @add background

module.exports = EBMenu