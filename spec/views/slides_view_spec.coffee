describe "SlidesView", ->
  beforeEach ->
    @tweets = new Twallaby.TweetsCollection(FIXTURES.tweets)
    @slidesView = new Twallaby.SlidesView(el: "<div><div class='the-canvas'></div></div>", collection: @tweets)
    @slidesView.render()

  describe "canvas", ->
    it "is the first child of the element", ->
      expect(@slidesView.$canvas.attr('class')).to.equal 'the-canvas'

  describe "adding a tweet", ->
    beforeEach ->
      @tweets.reset(FIXTURES.tweets)
      @tweets.add([{id: 1234, text: "hello world"}])

    it "renders the new tweet", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

    it "repositions the tweets", ->
      tweetElements = @slidesView.$('.tweet')
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(420px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-211px, -364px, 0px\)/