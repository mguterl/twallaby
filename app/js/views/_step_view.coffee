Twallaby.StepView = Backbone.View.extend
  className: "step"

  defaultStyles:
    position: "absolute"
    transformStyle: "preserve-3d"
    transition: "all 0.5s ease-in-out"

  currentPosition:
    x: 0
    y: 0
    z: 0

  currentRotation:
    x: 0
    y: 0
    z: 0

  currentScale: 1

  position: (positions) ->
    @currentPosition = positions
    @stylize()
    @

  scale: (scale) ->
    @currentScale = scale
    @stylize()
    @

  rotate: (rotations) ->
    @currentRotation = rotations
    @stylize()
    @

  stylize: ->
    tranforms = [
      "translate(-50%, -50%)"
      Twallaby.cssHelper.translate(@currentPosition)
      Twallaby.cssHelper.rotate(@currentRotation)
      Twallaby.cssHelper.scale(@currentScale)
    ].join(" ")
    @$el.applyStyles(transform: tranforms)
