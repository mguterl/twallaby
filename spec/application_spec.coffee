describe "Application", ->
  describe "options", ->
    describe "tweets", ->
      beforeEach ->
        @app = new Twallaby
          tweets: [{}, {}]
      it "sets the collections models", ->
        expect(@app.tweetsCollection.size()).to.equal 2

    describe "el", ->
      beforeEach ->
        @element = $("<div/>")
        @app = new Twallaby
          element: @element
      it "sets the slideViews el", ->
        expect(@app.stepsView.$el).to.equal @element

    describe "searchParams", ->
      beforeEach ->
        @app = new Twallaby
          twitterParams:
            foo: "bar"
            baz: "bing"
      it "sets the collections search params", ->
        expect(@app.tweetsCollection.twitterParams).to.deep.equal {
          foo: "bar"
          baz: "bing"
          page: 1
          rpp: 20
          result_type: 'recent'
        }

    describe "urlRoot", ->
      beforeEach ->
        @app = new Twallaby
          urlRoot:  'http://whatup.com'

      it "sets the collections url with the urlRoot", ->
        expect(@app.tweetsCollection.urlRoot).to.equal 'http://whatup.com'

    describe "pollInterval", ->
      beforeEach ->
        @app = new Twallaby
          pollInterval: 123

      it "sets the collections pollInterval", ->
        expect(@app.tweetsCollection.pollInterval).to.equal 123

    describe "#fetch", ->
      beforeEach ->
        @app = new Twallaby()
        @app.tweetsCollection.fetch = sinon.spy()
        @app.fetch()

      it "fetches the collections", ->
        expect(@app.tweetsCollection.fetch).to.have.been.called
