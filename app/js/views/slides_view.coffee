ImpressiveTwitter.Views.SlidesView = Backbone.View.extend
  id: "impress"

  template: JST['app/templates/index_view.us']

  delay: 4000
  announcementInterval: 5
  perspective: 1000
  transitionDuration: 1000

  events:
    'click .step': 'step'

  _paused: false
  _stepCount: 0

  defaultStyles:
    position: "absolute"
    transformOrigin: "top left"
    transition: "all 0s ease-in-out"
    transformStyle: "preserve-3d"

  initialize: ->
    @$canvas = @$('#canvas')
    @slideViews = []
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper
    @listenTo @collection, 'add', @appendTweet
    @listenTo @collection, 'reset', @renderTweets

  render: ->
    @$canvas.applyStyles(@defaultStyles)
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles
      top: "50%"
      left: "50%"
      transform: "#{@cssHelper.perspective(1000)} #{@cssHelper.scale( 1 )}"
    @

  renderTweets: ->
    for model in @collection.models
      tweetView = new ImpressiveTwitter.Views.TweetView(model: model)
      @position(tweetView)
      @$canvas.append(tweetView.render().el)
      @slideViews.push(tweetView)

  appendTweet: (model, options={}) ->
    @rearrangeViews()
    tweetView = new ImpressiveTwitter.Views.TweetView(model: model)
    @position(tweetView)
    @$canvas.append(tweetView.render().el)
    @slideViews.push(tweetView)

  position: (view) ->
    radius = 140 * @collection.size()
    theta = Math.PI * 2 / @collection.size()
    index = @collection.indexOf(view.model)
    view.position
      x: Math.floor(radius * Math.cos(index * theta))
      y: Math.floor(radius * Math.sin(index * theta))
      z: 0

  rearrangeViews: ->
    for view in @slideViews
      @position(view)

  step: ->
    @goToSlide(@randomTweetIndex())

  goToSlide: (index) ->
    @$el.applyStyles
      transitionDuration: "1000ms"

    @$canvas.applyStyles
      transform: @cssHelper.translate(@slideViews[index].coordinates.translate)
      transitionDuration: "1000ms"

  randomSlideIndex: ->
    @randomIntegerBetween(@$('.step').first().index(), @$('.step').last().index())

  randomAnnouncementIndex: ->
    @randomIntegerBetween(@$('.announcement').first().index(), @$('.announcement').last().index())

  randomTweetIndex: ->
    @randomIntegerBetween(@$('.tweet').first().index(), @$('.tweet').last().index())

  randomIntegerBetween: (from = 0, to = 0)->
    Math.floor(Math.random() * (to - from + 1) + from)

