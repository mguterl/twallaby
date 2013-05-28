describe "Application", ->
  describe "options", ->

    describe ".tweets", ->
      beforeEach ->
        @app = new Twallaby
          tweets: [{}, {}]
      it "sets the collections models", ->
        expect(@app.tweetsCollection.size()).to.equal 2

    describe ".el", ->
      beforeEach ->
        @element = $("<div/>")
        @app = new Twallaby
          element: @element
      it "sets the slideViews el", ->
        expect(@app.stepsView.$el).to.equal @element
