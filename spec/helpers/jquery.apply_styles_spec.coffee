describe "jquery.applyStyles", ->
  beforeEach ->
    @$elm = $('<div></div>')
    @elm = @$elm.get(0)
    @$elm.applyStyles(top: '100%')

  it "applies normal styles to an element", ->
    expect(@elm.style['top']).to.equal '100%'

  it "applies vendor-prefixed styles if the style is not supported", ->
    @$elm.applyStyles(transform: 'perspective(1)')
    expect(@elm.style['-webkit-transform']).to.equal 'perspective(1)'