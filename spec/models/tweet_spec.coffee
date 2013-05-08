describe "SlidesView", ->
  describe "bigger_profile_image_url", ->
    before ->
      @tweet = new ImpressiveTwitter.Models.Tweet
        profile_image_url: "http://www.whatever.com/normal.png"

    it "renders sweet tweets", ->
      expect(@tweet.get('bigger_profile_image_url')).to.equal "http://www.whatever.com/bigger.png"


