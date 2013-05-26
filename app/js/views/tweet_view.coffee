Twallaby.Views.TweetView = Backbone.View.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

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

  render: ->
    @$el.html(@template(@model))
    @$('.timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @

  position: (postions) ->
    @currentPosition = postions
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
