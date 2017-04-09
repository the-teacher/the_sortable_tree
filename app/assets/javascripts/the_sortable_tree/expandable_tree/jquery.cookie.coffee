#!
# * jQuery Cookie Plugin v1.3.1
# * https://github.com/carhartl/jquery-cookie
# *
# * Copyright 2013 Klaus Hartl
# * Released under the MIT license
# 
((factory) ->
  if typeof define is "function" and define.amd
    # AMD. Register as anonymous module.
    define ["jquery"], factory
  else
    # Browser globals.
    factory jQuery
) ($) ->
  pluses = /\+/g

  raw     = (s) -> s
  decoded = (s) -> decodeURIComponent s.replace(pluses, " ")
  converted = (s) ->
    # This is a quoted cookie as according to RFC2068, unescape
    s = s.slice(1, -1).replace(/\\"/g, "\"").replace(/\\\\/g, "\\")  if s.indexOf("\"") is 0
    try
      return (if config.json then JSON.parse(s) else s)

  
  config = $.cookie = (key, value, options) ->
    # write
    if value isnt `undefined`
      options = $.extend({}, config.defaults, options)
      
      if typeof options.expires is "number"
        days = options.expires
        t    = options.expires = new Date()
        t.setDate t.getDate() + days
      
      value = (if config.json then JSON.stringify(value) else String(value))
      
      # use expires attribute, max-age is not supported by IE
      return (document.cookie = [(if config.raw then key else encodeURIComponent(key)), "=", (if config.raw then value else encodeURIComponent(value)), (if options.expires then "; expires=" + options.expires.toUTCString() else ""), (if options.path then "; path=" + options.path else ""), (if options.domain then "; domain=" + options.domain else ""), (if options.secure then "; secure" else "")].join(""))
    
    # read
    decode  = (if config.raw then raw else decoded)
    cookies = document.cookie.split("; ")
    result  = (if key then `undefined` else {})

    i = 0
    l = cookies.length

    while i < l
      parts  = cookies[i].split("=")
      name   = decode parts.shift()
      cookie = decode parts.join("=")
      if key and key is name
        result = converted(cookie)
        break
      result[name] = converted(cookie)  unless key
      i++
    result

  config.defaults = {}

  $.removeCookie = (key, options) ->
    if $.cookie(key) isnt `undefined`
      # Must not alter options, thus extending a fresh object...
      $.cookie key, '', $.extend({}, options, expires: -1)
      return true
    false