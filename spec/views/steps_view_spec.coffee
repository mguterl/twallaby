describe "StepsView", ->
  beforeEach ->
    @tweets = new Twallaby.TweetsCollection(FIXTURES.tweets)
    @stepsView = new Twallaby.StepsView(el: "<div><div class='the-canvas'></div></div>", collection: @tweets)
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
      expect(tweetElements.get(0).style.cssText).to.match /translate3d\(420px, 0px, 0px\)/
      expect(tweetElements.get(2).style.cssText).to.match /translate3d\(-211px, -364px, 0px\)/

  describe "goToStep", ->
    beforeEach ->
      @stepsView.stepCount = 0
      @stepsView.$canvas.applyStyles = sinon.spy()

    describe "in bounds", ->
      beforeEach ->
        @stepsView.goToStep(1)
      it "increments stepCount", ->
        expect(@stepsView.stepCount).to.equal 1

    describe "out of bounds", ->
      beforeEach ->
        @stepsView.goToStep(1000)
      it "should not apply styles", ->
        expect(@stepsView.$canvas.applyStyles).to.not.have.been.called
      it "should not increment step count", ->
        expect(@stepsView.stepCount).to.equal 0

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
      @stepsView.goToStep = sinon.spy()

    describe "with an index", ->
      beforeEach ->
        @stepsView.goToTweet(10)
      it "goes to the index", ->
        expect(@stepsView.goToStep).to.have.been.calledWith(10)

    describe "without an index", ->
      beforeEach ->
        @stepsView.randomTweetIndex = sinon.spy()
        @stepsView.goToTweet()
      it "goes to a random tweet", ->
        expect(@stepsView.randomTweetIndex).to.have.been.called

  describe "goToAnnouncement", ->
    beforeEach ->
      @stepsView.goToStep = sinon.spy()

    describe "with an index", ->
      beforeEach ->
        @stepsView.goToAnnouncement(10)
      it "goes to the index", ->
        expect(@stepsView.goToStep).to.have.been.calledWith(10)

    describe "without an index", ->
      beforeEach ->
        @stepsView.randomAnnouncementIndex = sinon.spy()
        @stepsView.goToAnnouncement()
      it "goes to a random announcement", ->
        expect(@stepsView.randomAnnouncementIndex).to.have.been.called
