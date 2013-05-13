describe "SlidesView", ->
  beforeEach ->
    @tweets = new ImpressiveTwitter.Collections.Tweets(FIXTURES.tweets)
    @slidesView = new ImpressiveTwitter.Views.SlidesView(el: "<div><div id='canvas'></div></div>", collection: @tweets)

  describe "appendTweets", ->
    beforeEach ->
      @slidesView.appendTweets()
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

  describe "collection:sync", ->
    beforeEach ->
      @tweets.trigger('sync')
    it "renders sweet tweets", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

