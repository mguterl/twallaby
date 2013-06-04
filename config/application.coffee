# Exports an object that defines
#   all of the configuration needed by the projects'
#   depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require('lineman').config.extend('application', {

  prependTasks:
    dist: ["uglify:noVendor", "concat:noVendor", "something"]

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
      dest: "dist/js/twallaby.js"

  uglify:
    js:
      files:
        "dist/js/twallaby-all.min.js": "<%= files.glob.js.concatenated %>"

    noVendor:
      files:
        "dist/js/twallaby.min.js": "<%= files.js.noVendor %>"

  cssmin:
    compress:
      files:
        "dist/css/twallaby.min.css": "<%= files.glob.css.concatenated %>"

})