window.Page = {} if !window.Page

Page.visit = (url, opts={}) ->
  if opts.reload
    window.location = url
  else
    Turbolinks.visit(url)

Page.refresh = (options = {}, callback) ->
  newUrl = if options.url
    options.url
  else if options.queryParams
    paramString = $.param(options.queryParams)
    paramString = "?#{paramString}" if paramString
    location.pathname + paramString
  else
    location.href

  if options.response
    onlyKeys   = options.onlyKeys   || []
    exceptKeys = options.exceptKeys || []
    Turbolinks.loadPage null, options.response, true, true, callback, onlyKeys, exceptKeys
  else
    updatePushState = options.updatePushState
    updatePushState ?= true

    Turbolinks.visit newUrl, true, updatePushState, options.onlyKeys || [], -> callback?()

Page.open = ->
  window.open(arguments...)
