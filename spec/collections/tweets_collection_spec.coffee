describe "Tweets Collection", ->

  before ->
    @clock = sinon.useFakeTimers()

  after ->
    @clock.restore()

  beforeEach ->
    @tweetsCollection = new Twallaby.TweetsCollection
    @tweetsCollection.twitterParams = {}
    @tweetsCollection.fetch = sinon.spy()

  describe "url", ->
    describe "default", ->
      it "uses the default twitter search", ->
        expect(@tweetsCollection.url()).to.equal "http://search.twitter.com/search.json?callback=?"

    describe "with twitterParams", ->
      beforeEach ->
        @tweetsCollection.twitterParams =
          foo: "bar"
          baz: "bing"
      it "parses options", ->
        expect(@tweetsCollection.url()).to.equal "http://search.twitter.com/search.json?foo=bar&baz=bing&callback=?"

    describe "with a urlRoot", ->
      it "apply's the url root", ->
        @tweetsCollection.urlRoot = "http://whatup.com"
        expect(@tweetsCollection.url()).to.equal "http://whatup.com?callback=?"

  describe "polling", ->
    it "periodically fetches data from Twitter", ->
      @tweetsCollection.startPolling(50)
      @clock.tick(50)
      @tweetsCollection.stopPolling()
      expect(@tweetsCollection.fetch.called).to.equal true
