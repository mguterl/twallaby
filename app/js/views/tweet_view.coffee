ImpressiveTwitter.Views.TweetView = Backbone.View.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

  defaultStyles:
    position: "absolute"
    transformStyle: "preserve-3d"
    transition: "all 0.5s ease-in-out"

  initialize: (options = {}) ->
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper

  render: ->
    @$el.html(@template(@model))
    @$('.timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @

  position: (coordinates) ->
    @$el.applyStyles(transform: "translate(-50%,-50%) #{@cssHelper.translate(coordinates)}")