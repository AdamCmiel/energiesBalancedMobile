EBView = require "../EBView"
Surface = require "famous/core/Surface"
ScrollView = require "famous/views/ScrollView"
ImageSurface = require "famous/surfaces/ImageSurface"
Modifier = require "famous/core/Modifier"
Transform = require "famous/core/Transform"
$ = require "../../EBHttp"

EBInstagramListItem = require "./EBInstagramListItem"

class EBInstagramList extends EBView
  constructor: ->
    super
    @background = new Surface @options.background
    @add @background

    log "creating new instagram view"
    @scrollView = new ScrollView @options.scroll
    scrollViewPositioningModifier = new Modifier
      transform: Transform.translate 0, 10, 1
    @images = []
    @scrollView.sequenceFrom @images
    @add scrollViewPositioningModifier
    .add @scrollView
    @getImages().catch @error

EBInstagramList.DEFAULT_OPTIONS =
  scroll:
    clipSize: 600
    margin: 600
  background: classes: ["instagram-feed-background"]

EBInstagramList::getImages = ->
  $.get "https://s3-us-west-2.amazonaws.com/com.adamcmiel.energiesbalanced/eb_instagram_feed.json"
   .endAsync (data) =>
     imageData = JSON.parse data.text
     @addImages imageData

EBInstagramList::addImages = (data) ->
  log "Adding Images, API Version: #{data.api_version}"
  (@addImage imageURL for imageURL in data.images)

EBInstagramList::addImage = (url) ->
  image = new EBInstagramListItem url
  @scrollView.subscribe image
  @images.push image

EBInstagramList::Error = class EBInstagramListError extends Error
  constructor: (@message) ->
    @name = "EBInstagramListError"
    Error.captureStackTrace(this, EBInstagramListError)

module.exports = EBInstagramList
