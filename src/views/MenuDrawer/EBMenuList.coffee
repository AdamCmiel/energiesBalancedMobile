EBView = require "../EBView"
pages = require "../../pages"
EBMenuListItem = require "./EBMenuListItem"

class EBMenuList extends EBView
  constructor: ->
    super

    position = 0

    for title, page of pages
      if page == "splash" then continue
      item = new EBMenuListItem page: page, title: title, position: position
      @add item
      @subscribe item
      position++

    @pipeThrough "closeMenu"

module.exports = EBMenuList