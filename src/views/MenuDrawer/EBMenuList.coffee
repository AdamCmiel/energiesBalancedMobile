EBView = require "../EBView"
pages = require "../../pages"
EBMenuListItem = require "./EBMenuListItem"

class EBMenuList extends EBView
  constructor: ->
    super

    position = 0

    for title, page of pages
      @add new EBMenuListItem page: page, title: title, position: position
      position++

module.exports = EBMenuList