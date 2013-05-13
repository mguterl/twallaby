$.fn.applyStyles = (styles) ->
  for key, value of styles
    @[0].style[Modernizr.prefixed(key)] = value