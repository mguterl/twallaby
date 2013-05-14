$.fn.applyStyles = (styles) ->
  @each ->
    for key, value of styles
      @style[Modernizr.prefixed(key)] = value