class window.Twallaby
  constructor: (options={}) ->
    @tweetsCollection = new Twallaby.TweetsCollection(options.tweets)
    @slidesView = new Twallaby.SlidesView
      el: options.element
      collection: @tweetsCollection
    @slidesView.render()