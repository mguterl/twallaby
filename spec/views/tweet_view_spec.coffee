describe "TweetView", ->
  beforeEach ->
    @tweet = new Twallaby.Tweet(FIXTURES.tweets[0])
    @tweetView = new Twallaby.TweetView(model: @tweet)

  describe "render", ->
    beforeEach ->
      @tweetView.render()
    it "renders a sweet tweet", ->
      expect(@tweetView.$('.author').text()).to.equal "@#{@tweet.get('from_user')}"
    it "has a pretty timestamp", ->
      expect(@tweetView.$('.timestamp').text()).to.have.string('ago')
    it "applies the default styles", ->
      expect(@tweetView.el.style.cssText).to.match /position: absolute/