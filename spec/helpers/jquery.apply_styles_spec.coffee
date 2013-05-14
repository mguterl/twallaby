describe "jquery.applyStyles", ->
  describe "single element", ->
    beforeEach ->
      @$elm = $('<div></div>')
      @elm = @$elm.get(0)

    it "applies normal styles to an element", ->
      @$elm.applyStyles(top: '100%')
      expect(@elm.style['top']).to.equal '100%'

    it "applies vendor-prefixed styles if the style is not supported", ->
      @$elm.applyStyles(transform: 'perspective(1)')
      expect(@elm.style['-webkit-transform']).to.equal 'perspective(1)'

  describe "multiple elements", ->
    beforeEach ->
      @$elm = $('<div></div><div></div>')

    it "applies styles to each element", ->
      @$elm.applyStyles(top: '100%')
      expect(@$elm.get(0).style['top']).to.equal '100%'
      expect(@$elm.get(1).style['top']).to.equal '100%'