describe "randomHelper", ->
  describe "integerBetween", ->
    it "generates a random number", ->
      random = ImpressiveTwitter.randomHelper.integerBetween(2, 5)
      expect(random).to.be.above(1)
      expect(random).to.be.below(6)
