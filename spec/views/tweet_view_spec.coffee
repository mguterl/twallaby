describe "TweetView", ->
  beforeEach ->
    @tweet = new ImpressiveTwitter.Models.Tweet(FIXTURES.tweets[0])
    @tweetView = new ImpressiveTwitter.Views.TweetView(model: @tweet)

  describe "render", ->
    beforeEach ->
      @tweetView.render()
    it "renders a sweet tweet", ->
      expect(@tweetView.$('.author').text()).to.equal "@#{@tweet.get('from_user')}"
    it "has a pretty timestamp", ->
      expect(@tweetView.$('.timestamp').text()).to.have.string('ago');

  describe "position", ->
    beforeEach ->
      @tweetView.position(x: 1, y: 2, z: 3)
    it "applies a transform", ->
      expect(@tweetView.el.style.cssText).to.match /translate3d\(1px, 2px, 3px\)/
      expect(@tweetView.currentPosition).to.deep.equal(x: 1, y: 2, z: 3)
