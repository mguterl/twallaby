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

  coffee:
    app: [
      "app/js/*.coffee"
      "app/js/models/**/*.coffee"
      "app/js/collections/**/*.coffee"
      "app/js/helpers/**/*.coffee"
      "app/js/views/**/*.coffee"
    ]
    spec: "spec/**/*.coffee"
    specHelpers: "spec/spec_helper.coffee"
    generated: "generated/js/app.coffee.js"
    generatedSpecHelpers: "generated/js/spec-helpers.coffee.js"
    generatedSpec: "generated/js/spec.coffee.js"
});
