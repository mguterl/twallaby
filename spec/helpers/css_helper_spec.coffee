describe "CssHelper", ->
  beforeEach ->
    @elm = document.createElement('div')
    @cssHelper = new ImpressiveTwitter.Helpers.CssHelper

  afterEach ->
    @elm.remove()

  describe "translate", ->
    it "returns a translate string", ->
      expect(@cssHelper.translate(x: 1, y: 2, z: 3)).to.equal "translate3d(1px,2px,3px)"

  describe "rotate", ->
    it "returns a rotate string", ->
      expect(@cssHelper.rotate(1, 2, 3)).to.equal "rotateX(1deg) rotateY(2deg) rotateZ(3deg)"

  describe "scale", ->
    it "returns a scale string", ->
      expect(@cssHelper.scale(2)).to.equal "scale(2)"

  describe "perspective", ->
    it "returns a perspective string", ->
      expect(@cssHelper.perspective(2)).to.equal "perspective(2px)"

  describe "applyStylesTo", ->
    it "applies normal styles to an element", ->
      @cssHelper.applyStyles(@elm, top: '100%')
      expect(@elm.style['top']).to.equal '100%'

    it "applies vendor-prefixed styles if the style is not supported", ->
      @cssHelper.applyStyles(@elm, transform: 'perspective(1)')
      expect(@elm.style['-webkit-transform']).to.equal 'perspective(1)'
