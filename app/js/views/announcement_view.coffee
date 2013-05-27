Twallaby.AnnouncementView = Twallaby.StepView.extend
  className: "step announcement"

  render: ->
    @$el.applyStyles(@defaultStyles)
    @position
      x: @$el.data('x') || 0
      y: @$el.data('y') || 0
      z: @$el.data('z') || 0

    @rotate
      x: @$el.data('rotate-x') || 0
      y: @$el.data('rotate-y') || 0
      z: @$el.data('rotate-z') || 0

    @scale @$el.data('scale') || 0
    @