Twallaby.TweetsCollection = Backbone.Collection.extend
  model: Twallaby.Tweet

  twitterParams:
    page: 1
    rpp: 20
    q: "CWTDrinkUp"
    result_type: 'recent'

  startPolling: (interval) ->
    @interval = setInterval (=> @fetch()), interval || 60000

  stopPolling: ->
    clearInterval @interval

  url: ->
    urlParts = []
    for key, value of @twitterParams
      urlParts.push("#{key}=#{value}")
    encodeURI("/tweets?#{urlParts.join("&")}")

  parse: (resp, xhr) ->
    resp.results