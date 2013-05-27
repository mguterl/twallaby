describe "Application", ->
  describe "options", ->
    describe ".tweets", ->
      beforeEach ->
        @app = new Twallaby
          tweets: [{}, {}]
      it "sets the collections models", ->
        expect(@app.tweetsCollection.size()).to.equal 2
