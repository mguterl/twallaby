ImpressiveTwitter.Collections.Tweets = Backbone.Collection.extend
  model: ImpressiveTwitter.Models.Tweet

  twitterParams:
    page: 1
    rpp: 20
    q: "CWTDrinkUp"
    result_type: 'recent'

  url: ->
    urlParts = []
    for key, value of @twitterParams
      urlParts.push("#{key}=#{value}")
    urlParts.push("callback=?")
    encodeURI("http://search.twitter.com/search.json?#{urlParts.join("&")}")

  parse: (resp, xhr) ->
    resp.results