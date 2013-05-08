window.ImpressiveTwitter =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Helpers: {}

ImpressiveTwitter.init = ->
  tweetsCollection = new ImpressiveTwitter.Collections.Tweets()
  slidesView = new ImpressiveTwitter.Views.SlidesView(el: $('#slides'), collection: tweetsCollection)
  slidesView.render()
  tweetsCollection.fetch()
