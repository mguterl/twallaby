describe "SlidesView", ->
  beforeEach ->
    @tweets = new ImpressiveTwitter.Collections.Tweets(FIXTURES.tweets)
    @slidesView = new ImpressiveTwitter.Views.SlidesView(el: "<div><div id='canvas'></div></div>", collection: @tweets)

  describe "collection:reset", ->
    beforeEach ->
      @tweets.reset(FIXTURES.tweets)
    it "renders sweet tweets", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

  describe "adding a tweet", ->
    beforeEach ->
      @tweets.reset(FIXTURES.tweets)
      @tweets.add([{id: 1234, text: "hello world"}])

    it "renders the new tweet", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

    it "rearranges the arranges the tweets", ->
      tweetElements = @slidesView.$('.tweet')
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(420px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-211px, -364px, 0px\)/