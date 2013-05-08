describe "TweetView", ->
  beforeEach ->
    coordinates =
      translate:
        x: 1
        y: 2
        z: 3

    @tweet = new ImpressiveTwitter.Models.Tweet(FIXTURES.tweets[0])
    @tweetView = new ImpressiveTwitter.Views.TweetView(model: @tweet, coordinates: coordinates)

  describe "render", ->
    beforeEach ->
      @tweetView.render()
    it "renders a sweet tweet", ->
      expect(@tweetView.$('.author').text()).to.equal "@#{@tweet.get('from_user')}"
    it "has a pretty timestamp", ->
      expect(@tweetView.$('.timestamp').text()).to.have.string('ago');
    it "has styles based on its map", ->
      expect(@tweetView.el.style['-webkit-transform']).to.equal "translate(-50%, -50%) translate3d(1px, 2px, 3px)"
