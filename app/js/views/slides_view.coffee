Twallaby.SlidesView = Backbone.View.extend
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
    transition: "all 1s ease-in-out"
    transformStyle: "preserve-3d"

  initialize: ->
    @$canvas = @$el.children(':first')
    @slideViews = []
    @listenTo @collection, 'add', (model) ->
      @repositionViews()
      @appendTweet(model)
    @listenTo @collection, 'reset', @renderTweets

  render: ->
    @$canvas.applyStyles(@defaultStyles)
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles
      top: "50%"
      left: "50%"
      transform: "#{Twallaby.cssHelper.perspective(1000)} #{Twallaby.cssHelper.scale(1)}"
    @renderTweets()
    @

  renderTweets: ->
    for model in @collection.models
      @appendTweet(model)

  appendTweet: (model) ->
    tweetView = new Twallaby.TweetView(model: model)
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

  repositionViews: ->
    for view in @slideViews
      @position(view)

  step: ->
    @goToSlide(@randomTweetIndex())

  goToSlide: (index) ->
    @$canvas.applyStyles
      transform: Twallaby.cssHelper.translate(@slideViews[index].currentPosition)

  randomSlideIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.step').first().index(), @$('.step').last().index())

  randomAnnouncementIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.announcement').first().index(), @$('.announcement').last().index())

  randomTweetIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.tweet').first().index(), @$('.tweet').last().index())
