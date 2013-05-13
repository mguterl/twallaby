describe "SlidesView", ->
  beforeEach ->
    @tweets = new ImpressiveTwitter.Collections.Tweets
    @slidesView = new ImpressiveTwitter.Views.SlidesView(el: "<div><div id='canvas'></div></div>", collection: @tweets)
    @tweets.reset(FIXTURES.tweets)

  describe "renderTweets", ->
    it "renders sweet tweets", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

  describe "coordinatesFor", ->
    it "returns sweet coordinates", ->
      expect(@slidesView.coordinatesFor(1)).to.have.keys(['translate'])

  describe "randomIntegerBetween", ->
    it "gemerates a random number", ->
      random = @slidesView.randomIntegerBetween(2, 5)
      expect(random).to.be.above(1)
      expect(random).to.be.below(6)

  describe "collection:reset", ->
    it "renders sweet tweets", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

  describe "adding a tweet", ->
    beforeEach ->
      @tweets.add([{id: 1234, text: "hello world"}])

    it "renders the new tweet", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

    it.only "rearranges the arranges the tweets", ->
      tweetElements = @slidesView.$('.tweet')
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(420px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-211px, -364px, 0px\)/