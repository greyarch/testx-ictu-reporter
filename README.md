testx-ictu-reporter
=====

Simple test results reporter for ICTU quality system.

## Usage

# To add Jasmine reports to your test run
```
  reporter = require 'testx-ictu-reporter'
  reporter.addJasmineReporters
    junit: # set to false to omit this reporter
      dir: 'results/junit' # defaults to 'testresults/junit'
      filePrefix: 'junit-' # defaults to 'junit'
    html:  # set to false to omit this reporter
      dir: 'testresults/html' # defaults to 'testresults/html'
    spec:  # set to false to omit this reporter
      displayStacktrace: false # defaults to false

```

# To send results to your test results collection service
```
  reporter = require 'testx-ictu-reporter'
  reporter.sendResults 'http://path.to.trr.service', 'path/to/testresults.xml',
    appName: '[APP_NAME]'
    appVersion: '[APP_VERSION]'
    testDesc: '[TEST_DESCRIPTION]'
    testUser: '[TEST_USER]'
    testVersion: '[TEST_VERSION]'
    testTarget: '[TEST_TARGET]'
    testPlatform: '[TEST_PLATFORM]'
```
