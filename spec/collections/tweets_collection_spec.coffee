describe "Tweets Collection", ->

  before ->
    @clock = sinon.useFakeTimers()

  after ->
    @clock.restore()

  beforeEach ->
    @tweetsCollection = new Twallaby.TweetsCollection
    @tweetsCollection.fetch = sinon.spy()

  describe "url", ->
    it "parses options", ->
      @tweetsCollection.twitterParams = {
        foo: "bar"
        baz: "bing"
      }
      expect(@tweetsCollection.url()).to.equal "http://search.twitter.com/search.json?foo=bar&baz=bing&callback=?"

  describe "polling", ->
    it "periodically fetches data from Twitter", ->
      @tweetsCollection.startPolling(50)
      @clock.tick(50)
      @tweetsCollection.stopPolling()
      expect(@tweetsCollection.fetch.called).to.equal true
