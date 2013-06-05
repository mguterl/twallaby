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
    @tweetViews = []
    @announcementViews = []

    @listenTo @collection, 'add', (model) ->
      @repositionTweetViews()
      @appendTweet(model)
      @applyPerspective()

  render: ->
    @$canvas.applyStyles(@defaultStyles)
    @$el.applyStyles(@defaultStyles)
    @$el.applyStyles
      top: "50%"
      left: "50%"
    @applyPerspective()
    @renderAnnouncements()
    @renderTweets()
    @

  applyPerspective: ->
    @$el.applyStyles
      transform: "#{Twallaby.cssHelper.scale(1)}"

  renderTweets: ->
    for model in @collection.models
      @appendTweet(model)

  renderAnnouncements: ->
    for element in @$canvas.children()
      announcementView = new Twallaby.AnnouncementView(el: element)
      announcementView.render()
      @announcementViews.push(announcementView)

  appendTweet: (model) ->
    tweetView = new Twallaby.TweetView(model: model)
    @position(tweetView)
    @$canvas.append(tweetView.render().el)
    @tweetViews.push(tweetView)

  position: (view) ->
    radius = 400 * Math.sqrt(@collection.size())
    theta = Math.PI * 2 / @collection.size()
    index = @collection.indexOf(view.model)
    view.position
      x: Math.floor(radius * Math.cos(index * theta))
      y: Math.floor(radius * Math.sin(index * theta))
      z: 0

  repositionTweetViews: ->
    for view in @tweetViews
      @position(view)

  go: ->
    if @stepCount % @announcementInterval == 0
      @goToAnnouncement()
    else
      @goToTweet()

  goTo: (view) ->
    targetPosition =
      x: -view.currentPosition.x
      y: -view.currentPosition.y
      z: -view.currentPosition.z
    @$canvas.applyStyles
      transform: Twallaby.cssHelper.translate(targetPosition)
    @stepCount += 1

  goToTweet: (index)->
    @goTo(@tweetViews[index] || @tweetViews[@randomTweetIndex()])

  goToAnnouncement: (index)->
    @goTo(@announcementViews[index] || @announcementViews[@randomAnnouncementIndex()])

  randomAnnouncementIndex: ->
    Twallaby.randomHelper.integerBetween(0, @announcementViews.length - 1)

  randomTweetIndex: ->
    Twallaby.randomHelper.integerBetween(0, @tweetViews.length - 1)
