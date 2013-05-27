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
      @tweets.add([{id: 1234, text: "hello world"}])

    it "renders the new tweet", ->
      expect(@slidesView.$('.tweet').length).to.equal @tweets.size()

    it "repositions the tweets", ->
      tweetElements = @slidesView.$('.tweet')
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(420px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-211px, -364px, 0px\)/

  describe "goToIndex", ->
    beforeEach ->
      @slidesView.goToIndex(0)
    it "increments stepCount", ->
      expect(@slidesView.stepCount).to.equal 1

  describe "step", ->
    beforeEach ->
      @slidesView.goToTweet = sinon.spy()
      @slidesView.goToAnnouncement = sinon.spy()

    describe "when announcement interval is not reached", ->
      beforeEach ->
        @slidesView.stepCount = 1
        @slidesView.announcementInterval = 5
        @slidesView.step()

      it "goes to a tweet", ->
        expect(@slidesView.goToTweet.called).to.equal true

    describe "when announcement interval is reached", ->
      beforeEach ->
        @slidesView.stepCount = 5
        @slidesView.announcementInterval = 5
        @slidesView.step()

      it "goes to an announcement", ->
        expect(@slidesView.goToAnnouncement.called).to.equal true

  describe "goToTweet", ->
    beforeEach ->
      @slidesView.goToIndex = sinon.spy()

    describe "with an index", ->
      beforeEach ->
        @slidesView.goToTweet(10)
      it "goes to the index", ->
        expect(@slidesView.goToIndex.calledWith(10)).to.equal true

    describe "without an index", ->
      beforeEach ->
        @slidesView.randomTweetIndex = sinon.spy()
        @slidesView.goToTweet()
      it "goes to a random tweet", ->
        expect(@slidesView.randomTweetIndex.called).to.equal true

  describe "goToAnnouncement", ->
    beforeEach ->
      @slidesView.goToIndex = sinon.spy()

    describe "with an index", ->
      beforeEach ->
        @slidesView.goToAnnouncement(10)
      it "goes to the index", ->
        expect(@slidesView.goToIndex.calledWith(10)).to.equal true

    describe "without an index", ->
      beforeEach ->
        @slidesView.randomAnnouncementIndex = sinon.spy()
        @slidesView.goToAnnouncement()
      it "goes to a random announcement", ->
        expect(@slidesView.randomAnnouncementIndex.called).to.equal true

