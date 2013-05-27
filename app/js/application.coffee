class Twallaby
  constructor: (options={}) ->
    @tweetsCollection = new Twallaby.TweetsCollection(options.tweets)
    slidesView = new Twallaby.SlidesView(el: $('#slides'), collection: @tweetsCollection)
    slidesView.render()