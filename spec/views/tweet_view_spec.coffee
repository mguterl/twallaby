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
      expect(@tweetView.$('.timestamp').text()).to.have.string('ago');

  describe "position", ->
    beforeEach ->
      @tweetView.position(x: 1, y: 2, z: 3)
    it "applies a transform", ->
      expect(@tweetView.el.style.cssText).to.match /translate3d\(1px, 2px, 3px\)/
      expect(@tweetView.currentPosition).to.deep.equal(x: 1, y: 2, z: 3)

  describe "scale", ->
    beforeEach ->
      @tweetView.scale(2)
    it "applies a transform", ->
      expect(@tweetView.el.style.cssText).to.match /scale\(2\)/
      expect(@tweetView.currentScale).to.equal(2)

  describe "rotate", ->
    beforeEach ->
      @tweetView.rotate(x: 1, y: 2, z: 3)
    it "applies a transform", ->
      expect(@tweetView.el.style.cssText).to.match /rotateX\(1deg\) rotateY\(2deg\) rotateZ\(3deg\)/
      expect(@tweetView.currentRotation).to.deep.equal(x: 1, y: 2, z: 3)