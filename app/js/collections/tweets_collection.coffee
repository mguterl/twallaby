Twallaby.TweetsCollection = Backbone.Collection.extend
  model: Twallaby.Tweet

  twitterParams:
    page: 1
    rpp: 20
    result_type: 'recent'

  urlRoot: 'http://search.twitter.com/search.json'

  pollInterval: 60000

  initialize: (models, options={}) ->
    @twitterParams = _.extend({}, @twitterParams, options.twitterParams)
    @urlRoot = options.urlRoot if options.urlRoot
    @pollInterval = options.pollInterval if options.pollInterval

  startPolling: (interval) ->
    @fetch()
    @interval = setInterval (=> @fetch()), interval || @pollInterval

  stopPolling: ->
    clearInterval @interval

  url: ->
    urlParts = []
    for key, value of @twitterParams
      urlParts.push("#{key}=#{value}")
    urlParts.push("callback=?")
    encodeURI("#{@urlRoot}?#{urlParts.join("&")}")

  parse: (resp, xhr) ->
    resp.results