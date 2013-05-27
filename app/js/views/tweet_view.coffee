Twallaby.TweetView = Twallaby.StepView.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

  render: ->
    @$el.html(@template(@model))
    @$('.timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @
