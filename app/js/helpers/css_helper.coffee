class ImpressiveTwitter.Helpers.CssHelper
  translate: (coords = {}) ->
    "translate3d(#{coords.x || 0}px,#{coords.y || 0}px,#{coords.z || 0}px)"

  rotate: (x, y, z) ->
    "rotateX(#{x}deg) rotateY(#{y}deg) rotateZ(#{z}deg)"

  scale: (s) ->
    "scale(#{s})"

  perspective: (p) ->
    "perspective(#{p}px)"

  applyStyles: (element, styles) ->
    element = if element instanceof $ then element[0] else element
    for key, value of styles
      element.style[Modernizr.prefixed(key)] = value