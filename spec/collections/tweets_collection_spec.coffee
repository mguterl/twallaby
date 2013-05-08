describe "Tweets Collection", ->
  before ->
    @tweetsCollection = new ImpressiveTwitter.Collections.Tweets

  describe "url", ->
    it "parses options", ->
      @tweetsCollection.twitterParams = {
        foo: "bar"
        baz: "bing"
      }
      expect(@tweetsCollection.url()).to.equal "http://search.twitter.com/search.json?foo=bar&baz=bing&callback=?"
