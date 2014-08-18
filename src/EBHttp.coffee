request = require 'superagent'
Promise = require 'bluebird'
Promise.promisifyAll request.Request::
Promise.promisifyAll request.Response::

$ = {}
$.get = (path) ->
    log "GET #{path}"
    request.get path

module.exports = $
