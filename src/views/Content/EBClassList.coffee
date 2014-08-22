EBView = require "../EBView"
Surface = require "famous/core/Surface"

class EBClassList extends EBView
  constructor: ->
    super

    @background = new Surface @options.background
    @add @background

EBClassList.DEFAULT_OPTIONS =
  background: classes: ["class-list-background"]

module.exports = EBClassList