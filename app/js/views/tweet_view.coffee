ImpressiveTwitter.Views.TweetView = Backbone.View.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

  defaultStyles:
    position: "absolute"
    transformStyle: "preserve-3d"
    transition: "all 0.5s ease-in-out"

  initialize: (options = {}) ->
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper
    @coordinates = options.coordinates

  render: ->
    @$el.html(@template(@model))
    @$('.timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles(transform: "translate(-50%,-50%) #{@cssHelper.translate(@coordinates.translate)}")
    @

  setCoordinates: (coordinates) ->
    @coordinates = coordinates
    @$el.applyStyles(transform: "translate(-50%,-50%) #{@cssHelper.translate(@coordinates.translate)}")