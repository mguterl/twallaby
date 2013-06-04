this["JST"] = this["JST"] || {};

this["JST"]["app/templates/overview.us"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div id="overview" class="step" data-scale="' +
((__t = ( this.collection.size() / 3 )) == null ? '' : __t) +
'"></div>';

}
return __p
};

this["JST"]["app/templates/tweet.us"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="profile-image">\n  <img src="' +
((__t = ( get('profile_image_url') )) == null ? '' : __t) +
'" />\n</div>\n<div class="content">\n  <p class="author">@' +
((__t = ( get('from_user') )) == null ? '' : __t) +
'</p>\n  <q class="text">' +
((__t = ( get('text') )) == null ? '' : __t) +
'</q>\n  <p class="timestamp" title="' +
((__t = ( get('created_at') )) == null ? '' : __t) +
'"></p>\n</div>\n';

}
return __p
};
(function() {
  window.Twallaby = (function() {
    function Twallaby(options) {
      if (options == null) {
        options = {};
      }
      this.tweetsCollection = new Twallaby.TweetsCollection(options.tweets, {
        twitterParams: options.twitterParams,
        urlRoot: options.urlRoot,
        pollInterval: options.pollInterval
      });
      this.stepsView = new Twallaby.StepsView({
        el: options.element,
        collection: this.tweetsCollection
      });
      this.stepsView.render();
    }

    Twallaby.prototype.startPolling = function() {
      return this.tweetsCollection.startPolling();
    };

    return Twallaby;

  })();

  Twallaby.Tweet = Backbone.Model.extend({
    initialize: function() {
      if (this.get('profile_image_url') != null) {
        return this.set('bigger_profile_image_url', this.get('profile_image_url').replace('normal', 'bigger'));
      } else {
        return this.set('bigger_profile_image_url', void 0);
      }
    }
  });

  Twallaby.TweetsCollection = Backbone.Collection.extend({
    model: Twallaby.Tweet,
    twitterParams: {
      page: 1,
      rpp: 20,
      result_type: 'recent'
    },
    urlRoot: 'http://search.twitter.com/search.json',
    pollInterval: 60000,
    initialize: function(models, options) {
      if (options == null) {
        options = {};
      }
      this.twitterParams = _.extend({}, this.twitterParams, options.twitterParams);
      if (options.urlRoot) {
        this.urlRoot = options.urlRoot;
      }
      if (options.pollInterval) {
        return this.pollInterval = options.pollInterval;
      }
    },
    startPolling: function(interval) {
      var _this = this;

      this.fetch();
      return this.interval = setInterval((function() {
        return _this.fetch();
      }), interval || this.pollInterval);
    },
    stopPolling: function() {
      return clearInterval(this.interval);
    },
    url: function() {
      var key, urlParts, value, _ref;

      urlParts = [];
      _ref = this.twitterParams;
      for (key in _ref) {
        value = _ref[key];
        urlParts.push("" + key + "=" + value);
      }
      urlParts.push("callback=?");
      return encodeURI("" + this.urlRoot + "?" + (urlParts.join("&")));
    },
    parse: function(resp, xhr) {
      return resp.results;
    }
  });

  Twallaby.cssHelper = {
    translate: function(coords) {
      return "translate3d(" + (coords.x || 0) + "px," + (coords.y || 0) + "px," + (coords.z || 0) + "px)";
    },
    rotate: function(coords) {
      return "rotateX(" + (coords.x || 0) + "deg) rotateY(" + (coords.y || 0) + "deg) rotateZ(" + (coords.z || 0) + "deg)";
    },
    scale: function(s) {
      return "scale(" + (s || 1) + ")";
    },
    perspective: function(p) {
      return "perspective(" + p + "px)";
    }
  };

  $.fn.applyStyles = function(styles) {
    return this.each(function() {
      var key, value, _results;

      _results = [];
      for (key in styles) {
        value = styles[key];
        _results.push(this.style[Modernizr.prefixed(key)] = value);
      }
      return _results;
    });
  };

  Twallaby.randomHelper = {
    integerBetween: function(from, to) {
      if (from == null) {
        from = 0;
      }
      if (to == null) {
        to = 0;
      }
      return Math.floor(Math.random() * (to - from + 1) + from);
    }
  };

  Twallaby.StepView = Backbone.View.extend({
    className: "step",
    defaultStyles: {
      position: "absolute",
      transformStyle: "preserve-3d",
      transition: "all 0.5s ease-in-out"
    },
    currentPosition: {
      x: 0,
      y: 0,
      z: 0
    },
    currentRotation: {
      x: 0,
      y: 0,
      z: 0
    },
    currentScale: 1,
    position: function(positions) {
      this.currentPosition = positions;
      this.stylize();
      return this;
    },
    scale: function(scale) {
      this.currentScale = scale;
      this.stylize();
      return this;
    },
    rotate: function(rotations) {
      this.currentRotation = rotations;
      this.stylize();
      return this;
    },
    stylize: function() {
      var tranforms;

      tranforms = ["translate(-50%, -50%)", Twallaby.cssHelper.translate(this.currentPosition), Twallaby.cssHelper.rotate(this.currentRotation), Twallaby.cssHelper.scale(this.currentScale)].join(" ");
      return this.$el.applyStyles({
        transform: tranforms
      });
    }
  });

  Twallaby.AnnouncementView = Twallaby.StepView.extend({
    className: "step announcement",
    render: function() {
      this.$el.applyStyles(this.defaultStyles);
      this.position({
        x: this.$el.data('x') || 0,
        y: this.$el.data('y') || 0,
        z: this.$el.data('z') || 0
      });
      this.rotate({
        x: this.$el.data('rotate-x') || 0,
        y: this.$el.data('rotate-y') || 0,
        z: this.$el.data('rotate-z') || 0
      });
      this.scale(this.$el.data('scale') || 0);
      return this;
    }
  });

  Twallaby.StepsView = Backbone.View.extend({
    id: "impress",
    template: JST['app/templates/overview.us'],
    delay: 4000,
    announcementInterval: 5,
    perspective: 1000,
    transitionDuration: 1000,
    events: {
      'click': 'go'
    },
    paused: false,
    stepCount: 0,
    defaultStyles: {
      position: "absolute",
      transformOrigin: "top left",
      transition: "all 1s ease-in-out",
      transformStyle: "preserve-3d"
    },
    initialize: function() {
      this.$canvas = this.$el.children(':first');
      this.tweetViews = [];
      this.announcementViews = [];
      this.listenTo(this.collection, 'add', function(model) {
        this.repositionTweetViews();
        this.appendTweet(model);
        return this.applyPerspective();
      });
      return this.listenTo(this.collection, 'remove', function(model) {
        return console.log("remove", model);
      });
    },
    render: function() {
      this.$canvas.applyStyles(this.defaultStyles);
      this.$el.applyStyles(this.defaultStyles);
      this.$el.applyStyles({
        top: "50%",
        left: "50%"
      });
      this.applyPerspective();
      this.renderAnnouncements();
      this.renderTweets();
      return this;
    },
    applyPerspective: function() {
      return this.$el.applyStyles({
        transform: "" + (Twallaby.cssHelper.perspective(1000)) + " " + (Twallaby.cssHelper.scale(0.7))
      });
    },
    renderTweets: function() {
      var model, _i, _len, _ref, _results;

      _ref = this.collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        _results.push(this.appendTweet(model));
      }
      return _results;
    },
    renderAnnouncements: function() {
      var announcementView, element, _i, _len, _ref, _results;

      _ref = this.$canvas.children();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        element = _ref[_i];
        announcementView = new Twallaby.AnnouncementView({
          el: element
        });
        announcementView.render();
        _results.push(this.announcementViews.push(announcementView));
      }
      return _results;
    },
    appendTweet: function(model) {
      var tweetView;

      tweetView = new Twallaby.TweetView({
        model: model
      });
      this.position(tweetView);
      this.$canvas.append(tweetView.render().el);
      return this.tweetViews.push(tweetView);
    },
    position: function(view) {
      var index, radius, theta;

      radius = 100 * this.collection.size();
      theta = Math.PI * 2 / this.collection.size();
      index = this.collection.indexOf(view.model);
      return view.position({
        x: Math.floor(radius * Math.cos(index * theta)),
        y: Math.floor(radius * Math.sin(index * theta)),
        z: 0
      });
    },
    repositionTweetViews: function() {
      var view, _i, _len, _ref, _results;

      _ref = this.tweetViews;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        _results.push(this.position(view));
      }
      return _results;
    },
    go: function() {
      if (this.stepCount % this.announcementInterval === 0) {
        return this.goToAnnouncement();
      } else {
        return this.goToTweet();
      }
    },
    goTo: function(view) {
      var targetPosition;

      targetPosition = {
        x: -view.currentPosition.x,
        y: -view.currentPosition.y,
        z: -view.currentPosition.z
      };
      console.log(targetPosition);
      this.$canvas.applyStyles({
        transform: Twallaby.cssHelper.translate(targetPosition)
      });
      return this.stepCount += 1;
    },
    goToTweet: function(index) {
      return this.goTo(this.tweetViews[index] || this.tweetViews[this.randomTweetIndex()]);
    },
    goToAnnouncement: function(index) {
      return this.goTo(this.announcementViews[index] || this.announcementViews[this.randomAnnouncementIndex()]);
    },
    randomAnnouncementIndex: function() {
      return Twallaby.randomHelper.integerBetween(0, this.announcementViews.length);
    },
    randomTweetIndex: function() {
      return Twallaby.randomHelper.integerBetween(0, this.tweetViews.length);
    }
  });

  Twallaby.TweetView = Twallaby.StepView.extend({
    className: "step tweet",
    template: JST['app/templates/tweet.us'],
    render: function() {
      this.$el.html(this.template(this.model));
      this.$('.timestamp').timeago();
      this.$el.applyStyles(this.defaultStyles);
      return this;
    }
  });

}).call(this);
