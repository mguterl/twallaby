describe "CssHelper", ->
  beforeEach ->
    @elm = document.createElement('div')
    @cssHelper = Twallaby.cssHelper

  afterEach ->
    @elm.remove()

  describe "translate", ->
    it "returns a translate string", ->
      expect(@cssHelper.translate(x: 1, y: 2, z: 3)).to.equal "translate3d(1px,2px,3px)"

  describe "rotate", ->
    it "returns a rotate string", ->
      expect(@cssHelper.rotate(x: 1, y: 2, z: 3)).to.equal "rotateX(1deg) rotateY(2deg) rotateZ(3deg)"

  describe "scale", ->
    it "returns a scale string", ->
      expect(@cssHelper.scale(2)).to.equal "scale(2)"

  describe "perspective", ->
    it "returns a perspective string", ->
      expect(@cssHelper.perspective(2)).to.equal "perspective(2px)"
