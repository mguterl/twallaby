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
      @announcementViews.push(announcementView)

  appendTweet: (model) ->
    tweetView = new Twallaby.TweetView(model: model)
    @position(tweetView)
    @$canvas.append(tweetView.render().el)
    @tweetViews.push(tweetView)

  position: (view) ->
    radius = 140 * @collection.size()
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
    @$canvas.applyStyles
      transform: Twallaby.cssHelper.translate(view.currentPosition)
    @stepCount += 1

  goToTweet: (index)->
    @goTo(@tweetViews[index] || @tweetViews[@randomTweetIndex()])

  goToAnnouncement: (index)->
    @goTo(@announcementViews[index] || @announcementViews[@randomAnnouncementIndex()])

  randomAnnouncementIndex: ->
    Twallaby.randomHelper.integerBetween(0, @announcementViews.length)

  randomTweetIndex: ->
    Twallaby.randomHelper.integerBetween(0, @tweetViews.length)