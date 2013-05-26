Twallaby.cssHelper =
  translate: (coords) ->
    "translate3d(#{coords.x || 0}px,#{coords.y || 0}px,#{coords.z || 0}px)"

  rotate: (coords) ->
    "rotateX(#{coords.x || 0}deg) rotateY(#{coords.y || 0}deg) rotateZ(#{coords.z || 0}deg)"

  scale: (s) ->
    "scale(#{s || 1})"

  perspective: (p) ->
    "perspective(#{p}px)"
