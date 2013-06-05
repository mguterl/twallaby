describe "StepsView", ->
  beforeEach ->
    @tweets = new Twallaby.TweetsCollection(FIXTURES.tweets)
    @stepsView = new Twallaby.StepsView
      el: "<div><div class='the-canvas'><div/><div/></div></div>"
      collection: @tweets
    @stepsView.render()

  describe "canvas", ->
    it "is the first child of the element", ->
      expect(@stepsView.$canvas.attr('class')).to.equal 'the-canvas'

  describe "adding a tweet", ->
    beforeEach ->
      @tweets.add([{id: 1234, text: "hello world"}])
    it "renders the new tweet", ->
      expect(@stepsView.$('.tweet').length).to.equal @tweets.size()
    it "repositions the tweets", ->
      tweetElements = @stepsView.$('.tweet')
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(692px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-347px, -600px, 0px\)/

  describe "goTo", ->
    beforeEach ->
      @stepsView.stepCount = 0
      @stepsView.$canvas.applyStyles = sinon.spy()
      @stepsView.goTo(@stepsView.tweetViews[0])
    it "increments", ->
      expect(@stepsView.stepCount).to.equal 1

  describe "go", ->
    beforeEach ->
      @stepsView.goToTweet = sinon.spy()
      @stepsView.goToAnnouncement = sinon.spy()

    describe "when announcement interval is not reached", ->
      beforeEach ->
        @stepsView.stepCount = 1
        @stepsView.announcementInterval = 5
        @stepsView.go()
      it "goes to a tweet", ->
        expect(@stepsView.goToTweet).to.have.been.called

    describe "when announcement interval is reached", ->
      beforeEach ->
        @stepsView.stepCount = 5
        @stepsView.announcementInterval = 5
        @stepsView.go()
      it "goes to an announcement", ->
        expect(@stepsView.goToAnnouncement).to.have.been.called

  describe "goToTweet", ->
    beforeEach ->
      @stepsView.goTo = sinon.spy()

    describe "with an index", ->
      describe "in bounds", ->
        beforeEach ->
          @stepsView.goToTweet(1)
        it "goes to the index", ->
          expect(@stepsView.goTo).to.have.been.calledWith(@stepsView.tweetViews[1])

      describe "out of bounds", ->
        beforeEach ->
          @stepsView.randomTweetIndex = sinon.spy()
          @stepsView.goToTweet(100)
        it "goes to a random index", ->
          expect(@stepsView.randomTweetIndex).to.have.been.called

      describe "without an index", ->
        beforeEach ->
          @stepsView.randomTweetIndex = sinon.spy()
          @stepsView.goToTweet()
        it "goes to a random index", ->
          expect(@stepsView.randomTweetIndex).to.have.been.called

    describe "without an index", ->
      beforeEach ->
        @stepsView.randomTweetIndex = sinon.spy()
        @stepsView.goToTweet()
      it "goes to a random tweet", ->
        expect(@stepsView.randomTweetIndex).to.have.been.called

  describe "goToAnnouncement", ->
    beforeEach ->
      @stepsView.goTo = sinon.spy()

    describe "with an index", ->
      describe "in bounds", ->
        beforeEach ->
          @stepsView.goToAnnouncement(1)
        it "goes to the index", ->
          expect(@stepsView.goTo).to.have.been.calledWith(@stepsView.announcementViews[1])

      describe "out of bounds", ->
        beforeEach ->
          @stepsView.randomAnnouncementIndex = sinon.spy()
          @stepsView.goToAnnouncement(100)
        it "goes to a random index", ->
          expect(@stepsView.randomAnnouncementIndex).to.have.been.called

  describe "applyPerspective", ->
    beforeEach ->
      @stepsView.applyPerspective()
    it "applies a perspective to the el", ->
      expect(@stepsView.el.style.cssText).to.match /scale/

  describe "removeing a tweet", ->
    beforeEach ->
      @stepsView.repositionTweetViews = sinon.spy()
      @tweets.remove(@tweets.first())
    it "repositions the tweets", ->
      expect(@stepsView.repositionTweetViews).to.have.been.called
    it "removes the view", ->
      expect(@stepsView.$('.tweet').length).to.equal 1
