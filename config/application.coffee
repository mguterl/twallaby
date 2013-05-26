# Exports an object that defines
#   all of the configuration needed by the projects'
#   depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require('lineman').config.extend('application', {

  coffee:
    compile:
      files:
        "generated/js/app.coffee.js": "<%= files.coffee.app %>"
        "generated/js/spec.coffee.js": "<%= files.coffee.spec %>"
        "generated/js/spec-helpers.coffee.js": "<%= files.coffee.specHelpers %>"
      options:
        bare: true
})