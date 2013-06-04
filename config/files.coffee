 #  Exports an object that defines
 #   all of the paths & globs that the project
 #   is concerned with.
 #
 #  The "configure" task will require this file and
 #   then re-initialize the grunt config such that
 #   directives like <config:files.js.app> will work
 #   regardless of the point you're at in the build
 #   lifecycle.
 #
 #  You can find the parent object in: node_modules/lineman/config/files.coffee


module.exports = require('lineman').config.extend('files', {

  js:
    vendor: [
      "vendor/js/underscore.js"
      "vendor/js/jquery.js"
      "vendor/js/backbone.js"
      "vendor/js/**/*.js"
    ]
    concatenated: "generated/js/twallaby-all.js"
    minified: "dist/js/twallaby-all.min.js"
    noVendor: "dist/js/twallaby.js"

  coffee:
    app: [
      "app/js/*.coffee"
      "app/js/models/**/*.coffee"
      "app/js/collections/**/*.coffee"
      "app/js/helpers/**/*.coffee"
      "app/js/views/**/*.coffee"
    ]
    generated: "generated/js/twallaby.js"

  template:
    homepage: "app/index.us"

});
