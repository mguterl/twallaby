ImpressiveTwitter.Views.SlidesView = Backbone.View.extend
  id: "impress"

  template: JST['app/templates/index_view.us']

  delay: 4000
  announcementInterval: 5
  perspective: 1000
  transitionDuration: 1000

  events:
    'click .step': 'togglePaused'

  _paused: false
  _stepCount: 0

  defaultStyles:
    position: "absolute"
    transformOrigin: "top left"
    transition: "all 0s ease-in-out"
    transformStyle: "preserve-3d"

  initialize: ->
    @createCanvas()
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper
    @collection.on 'sync', @appendTweets, @

  createCanvas: ->
    @$el.append("<div id='canvas'/>") unless @$('#canvas').length
    @$canvas = @$('#canvas')
    @$canvas

  render: ->
    @cssHelper.applyStyles(@$canvas, @defaultStyles)
    @cssHelper.applyStyles(@$el, @defaultStyles)
    @cssHelper.applyStyles @$el, {
      top: "50%"
      left: "50%"
      transform: "#{@cssHelper.perspective(1000)} #{@cssHelper.scale( 1 )}"
    }
    @

  appendTweets: ->
    for model, i in @collection.models
      tweetView = new ImpressiveTwitter.Views.TweetView(model: model, coordinates: @coordinatesFor)
      @$canvas.append(tweetView.render().el)

  coordinatesFor: (index) ->
    radius = 140 * @collection.size()
    theta = Math.PI * 2 / @collection.size()
    {
      translate:
        x: Math.floor(radius * Math.cos(index * theta))
        y: Math.floor(radius * Math.sin(index * theta))
        z: 0
    }

  step: ->
    if @_stepCount % 10 == 0
      @goToSlide('overview')
    else if @_stepCount % @announcementInterval == 0
      @goToSlide(@randomAnnouncementIndex())
    else
      @goToSlide(@randomTweetIndex())
    @_stepCount = @_stepCount + 1

  goToSlide: (index) ->
    return if @_paused
    # @impress.goto(index)

  randomSlideIndex: ->
    @randomIntegerBetween(@$('.step').first().index(), @$('.step').last().index())

  randomAnnouncementIndex: ->
    @randomIntegerBetween(@$('.announcement').first().index(), @$('.announcement').last().index())

  randomTweetIndex: ->
    @randomIntegerBetween(@$('.tweet').first().index(), @$('.tweet').last().index())

  randomIntegerBetween: (from = 0, to = 0)->
    Math.floor(Math.random() * (to - from + 1) + from)

