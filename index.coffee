FormData = require 'form-data'
fs = require 'fs'

addJunitReporter = (opts) ->
  unless opts is false
    require 'jasmine-reporters'
    dir = opts?.dir || 'testresults/junit'
    file = opts?.file || 'junit'
    console.log dir, file
    # jasmine.getEnv().addReporter(new jasmine.JUnitXmlReporter dir, true, true, file, true)

addHtmlReporter = (opts) ->
  unless opts is false
    HtmlReporter = require 'protractor-html-screenshot-reporter'
    dir = opts?.dir ||'testresults/html'
    jasmine.getEnv().addReporter(new HtmlReporter baseDirectory: dir)

addSpecReporter = (opts) ->
  unless opts is false
    require 'jasmine-spec-reporter'
    jasmine.getEnv().addReporter new jasmine.SpecReporter(displayStacktrace: opts?.displayStacktrace || false)

addReporters = (opts) ->
  addJunitReporter opts?.junit
  addHtmlReporter opts?.html
  addSpecReporter opts?.spec

sendResults = (url, reportFile, options) ->
  console.log "Sending test results from #{reportFile} to the repository at #{url}"
  fs.stat reportFile, (err, stat) ->
    if err
      throw new Error "Could not find file #{reportFile}."
    else
      if stat.isFile()
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
      else
        throw new Error "#{reportFile} is not a file."
module.exports =
  sendResults: sendResults
  addJasmineReporters: addReporters
