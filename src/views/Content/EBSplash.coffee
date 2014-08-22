EBView = require '../EBView'
Surface = require "famous/core/Surface"

class EBSplash extends EBView
  constructor: ->
    super
    @add new Surface properties: backgroundColor: 'blue'

  start: ->
    setTimeout(=>
      @_eventOutput.emit "splashPageComplete"
    , 1000)

module.exports = EBSplash