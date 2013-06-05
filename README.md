# Twallaby

## Getting Started

`git clone git://github.com/gaslight/twallaby.git`

`cd twallaby`

`npm install`

`npm install lineman -g`

`lineman run`

`open http://locahost:8000`

## Test

* `lineman spec`

## Build

* `lineman build`

## API

```javascript
var tweetWall = new Twallaby({
  element: $('#slides')
  pollInterval: 10000
  twitterParams:
    q: 'CWTDrinkup'
    rpp: 25
})

tweetWall.startPolling()
```
