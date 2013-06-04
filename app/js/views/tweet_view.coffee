Twallaby.TweetView = Twallaby.StepView.extend
  className: "step tweet"

  template: JST['app/templates/tweet.us']

  render: ->
    @$el.html(@template(@model))
    @$('.tweet__timestamp').timeago()
    @$el.applyStyles(@defaultStyles)
    @
