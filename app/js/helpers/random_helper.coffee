Twallaby.randomHelper =
  integerBetween: (from = 0, to = 0)->
    Math.floor(Math.random() * (to - from + 1) + from)