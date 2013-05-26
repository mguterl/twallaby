describe "TweetModel", ->
  describe "bigger_profile_image_url", ->
    before ->
      @tweet = new Twallaby.Models.Tweet
        profile_image_url: "http://www.whatever.com/normal.png"

    it "Sets it on init", ->
      expect(@tweet.get('bigger_profile_image_url')).to.equal "http://www.whatever.com/bigger.png"


