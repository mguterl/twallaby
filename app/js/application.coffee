class window.Twallaby
  constructor: (options={}) ->
    @tweetsCollection = new Twallaby.TweetsCollection options.tweets,
      twitterParams: options.twitterParams
      urlRoot: options.urlRoot
      pollInterval: options.pollInterval

    @stepsView = new Twallaby.StepsView
      el: options.element
      collection: @tweetsCollection

    @stepsView.render()

  startPolling: ->
    @tweetsCollection.startPolling()

  fetch: ->
    @tweetsCollection.fetch()