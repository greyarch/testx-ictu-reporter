FormData = require 'form-data'
fs = require 'fs'

addReporters = (opts) ->
  unless opts?.junit is false
    require 'jasmine-reporters'
    dir = opts?.html?.dir || 'testresults/junit'
    file = opts?.html?.file || 'junit'
    jasmine.getEnv().addReporter(new jasmine.JUnitXmlReporter dir, true, true, file, true)

  unless opts?.html is false
    HtmlReporter = require 'protractor-html-screenshot-reporter'
    dir = opts?.html?.dir ||'testresults/html'
    jasmine.getEnv().addReporter(new HtmlReporter baseDirectory: dir)

  unless opts?.spec is false
    require 'jasmine-spec-reporter'
    jasmine.getEnv().addReporter new jasmine.SpecReporter(displayStacktrace: opts?.spec?.displayStacktrace || false)


sendResults = (url, reportFile, options) ->
  console.log "Sending test results from #{reportFile} to the repository at #{url}"
  form = new FormData()
  form.append 'junit', fs.createReadStream(reportFile)
  form.append 'application_name', options.appName || 'unknown'
  form.append 'application_version', options.appVersion || '0'
  form.append 'testrun_description', options.testDesc || 'ART'
  form.append 'testrun_user', options.testUser || 'unknown'
  form.append 'testrun_version', options.testVersion || '0'
  form.append 'test_target', options.testTarget || 'unknown'
  form.append 'test_platform', options.testPlatform || 'chrome'
  form.submit url, (err, res) ->
    if err then throw err
    console.log 'Results sent!'

module.exports =
  sendResults: sendResults
  addJasmineReporters: -> addReporters browser?.params?.testx?.reporters
