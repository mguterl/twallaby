describe "StepView", ->
  beforeEach ->
    @stepView = new Twallaby.StepView

  describe "position", ->
    beforeEach ->
      @stepView.position(x: 1, y: 2, z: 3)
    it "applies a transform", ->
      expect(@stepView.el.style.cssText).to.match /translate3d\(1px, 2px, 3px\)/
      expect(@stepView.currentPosition).to.deep.equal(x: 1, y: 2, z: 3)

  describe "scale", ->
    beforeEach ->
      @stepView.scale(2)
    it "applies a transform", ->
      expect(@stepView.el.style.cssText).to.match /scale\(2\)/
      expect(@stepView.currentScale).to.equal(2)

  describe "rotate", ->
    beforeEach ->
      @stepView.rotate(x: 1, y: 2, z: 3)
    it "applies a transform", ->
      expect(@stepView.el.style.cssText).to.match /rotateX\(1deg\) rotateY\(2deg\) rotateZ\(3deg\)/
      expect(@stepView.currentRotation).to.deep.equal(x: 1, y: 2, z: 3)