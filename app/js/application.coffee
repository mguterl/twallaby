class window.Twallaby
  constructor: (options={}) ->
    @tweetsCollection = new Twallaby.TweetsCollection(options.tweets)
    @stepsView = new Twallaby.StepsView
      el: options.element
      collection: @tweetsCollection
    @stepsView.render()