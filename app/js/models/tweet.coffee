ImpressiveTwitter.Models.Tweet = Backbone.Model.extend
  initialize: ->
    @set 'bigger_profile_image_url', @get('profile_image_url').replace('normal', 'bigger')
