describe "AnnouncementView", ->
  describe "render", ->
    beforeEach ->
      @announcementView = new Twallaby.AnnouncementView
        el: $('<div data-x="1" data-y="2" data-z="3" data-rotate-x="4" data-rotate-y="5" data-rotate-z="6" data-scale="7"></div>')
      @announcementView.render()

    it "applies the default styles", ->
      expect(@announcementView.el.style.cssText).to.match /position: absolute/

    it "positions the view based on data attributes", ->
      expect(@announcementView.currentPosition).to.deep.equal {x: 1, y: 2, z: 3}
      expect(@announcementView.el.style.cssText).to.match /translate3d\(1px, 2px, 3px\)/

    it "rotates the view based on data attributes", ->
      expect(@announcementView.el.style.cssText).to.match /rotateX\(4deg\) rotateY\(5deg\) rotateZ\(6deg\)/
      expect(@announcementView.currentRotation).to.deep.equal(x: 4, y: 5, z: 6)

    it "scales the view based on data attributes", ->
      expect(@announcementView.el.style.cssText).to.match /scale\(7\)/
      expect(@announcementView.currentScale).to.equal(7)

