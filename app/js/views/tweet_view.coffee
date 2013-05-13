ImpressiveTwitter.Views.TweetView = Backbone.View.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

  defaultStyles:
    position: "absolute"
    transformStyle: "preserve-3d"

  initialize: (options = {}) ->
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper
    @coordinates = options.coordinates

  render: ->
    @$el.html(@template(@model.toJSON()))
    @$('.timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles(transform: "translate(-50%,-50%) #{@cssHelper.translate(@coordinates.translate)}")
    @