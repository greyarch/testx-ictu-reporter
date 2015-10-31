FormData = require 'form-data'
fs = require 'fs'

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
  addJasmineReporters: require('testx-jasmine-reporters')
