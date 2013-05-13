ImpressiveTwitter.Models.Tweet = Backbone.Model.extend
  initialize: ->
    if @get('profile_image_url')?
      @set 'bigger_profile_image_url', @get('profile_image_url').replace('normal', 'bigger')
    else
      @set 'bigger_profile_image_url', 'random.png'