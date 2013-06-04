# Exports an object that defines
#   all of the configuration needed by the projects'
#   depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require('lineman').config.extend('application', {

  prependTasks:
    dist: ["concat:all", "concat:distAll", "concat:noVendor", "uglify:noVendor"]

  coffee:
    compile:
      files:
        "generated/js/twallaby.js": "<%= files.coffee.app %>"

      options:
        bare: false
        join: true

  concat:
    noVendor:
      src: ["<banner:meta.banner>", "<%= files.template.generated %>", "<%= files.coffee.generated %>", "<%= files.js.app %>"]
      dest: "<%= files.js.concatenatedNoVendor %>"
    all:
      src: ["<banner:meta.banner>", "<%= files.js.vendor %>", "<%= files.template.generated %>", "<%= files.coffee.generated %>", "<%= files.js.app %>"]
      dest: "<%= files.js.concatenatedAll %>"
    distAll:
      src: ["<banner:meta.banner>", "<%= files.js.vendor %>", "<%= files.template.generated %>", "<%= files.coffee.generated %>", "<%= files.js.app %>"]
      dest: "<%= files.js.distAll %>"

  uglify:
    js:
      files:
        "dist/js/twallaby-all.min.js": "<%= files.js.concatenated %>"

    noVendor:
      files:
        "dist/js/twallaby.min.js": "<%= files.js.concatenatedNoVendor %>"

  cssmin:
    compress:
      files:
        "dist/css/twallaby.min.css": "<%= files.css.concatenated %>"

  homepage:
    template: "<%= files.template.homepage %>"
    dev:
      dest: "generated/index.html"
      context:
        js: "js/twallaby-all.js"
        css: "css/app.css"

    dist:
      dest: "dist/index.html"
      context:
        js: "js/twallaby-all.min.js"
        css: "css/app.min.css"

})