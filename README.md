# Twallaby

### Install
* `npm install`
* `npm install lineman -g`

### Run
* `lineman run`

### Test
* `lineman spec`

### Build
* `lineman build`

### API
    var tweetWall = new Twallaby({
      element: $('#slides')
      pollInterval: 10000
      twitterParams:
        q: 'CWTDrinkup'
        rpp: 25
    })

    tweetWall.startPolling()