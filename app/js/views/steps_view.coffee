Twallaby.StepsView = Backbone.View.extend
  id: "impress"
  template: JST['app/templates/overview.us']

  delay: 4000
  announcementInterval: 5
  perspective: 1000
  transitionDuration: 1000

  events:
    'click': 'go'

  paused: false
  stepCount: 0

  defaultStyles:
    position: "absolute"
    transformOrigin: "top left"
    transition: "all 1s ease-in-out"
    transformStyle: "preserve-3d"

  initialize: ->
    @$canvas = @$el.children(':first')
    @childViews = []
    @listenTo @collection, 'add', (model) ->
      @repositionViews()
      @appendTweet(model)

  render: ->
    @$canvas.applyStyles(@defaultStyles)
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles
      top: "50%"
      left: "50%"
      transform: "#{Twallaby.cssHelper.perspective(1000)} #{Twallaby.cssHelper.scale(1)}"
    @renderAnnouncements()
    @renderTweets()
    @

  renderTweets: ->
    for model in @collection.models
      @appendTweet(model)

  renderAnnouncements: ->
    for element in @$canvas.children()
      announcementView = new Twallaby.AnnouncementView(el: element)
      announcementView.render()
      @childViews.push(announcementView)

  appendTweet: (model) ->
    tweetView = new Twallaby.TweetView(model: model)
    @position(tweetView)
    @$canvas.append(tweetView.render().el)
    @childViews.push(tweetView)

  position: (view) ->
    radius = 140 * @collection.size()
    theta = Math.PI * 2 / @collection.size()
    index = @collection.indexOf(view.model)
    view.position
      x: Math.floor(radius * Math.cos(index * theta))
      y: Math.floor(radius * Math.sin(index * theta))
      z: 0

  repositionViews: ->
    for view in @childViews
      @position(view)

  go: ->
    if @stepCount % @announcementInterval == 0
      @goToAnnouncement()
    else
      @goToTweet()

  goToStep: (index) ->
    targetView = @childViews[index]
    return unless targetView?
    @$canvas.applyStyles
      transform: Twallaby.cssHelper.translate(targetView.currentPosition)
    @stepCount += 1

  goToTweet: (index)->
    @goToStep(index || @randomTweetIndex())

  goToAnnouncement: (index)->
    @goToStep(index || @randomAnnouncementIndex())

  randomStepIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.step').first().index(), @$('.step').last().index())

  randomAnnouncementIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.announcement').first().index(), @$('.announcement').last().index())

  randomTweetIndex: ->
    Twallaby.randomHelper.integerBetween(@$('.tweet').first().index(), @$('.tweet').last().index())
