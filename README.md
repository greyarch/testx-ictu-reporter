testx-ictu-reporter
=====

Simple test results reporter for ICTU quality system.

## Usage

### To add Jasmine reports to your test run
```
  reporter = require 'testx-ictu-reporter'
  reporter.addJasmineReporters
    junit: # set to false to omit this reporter
      dir: 'results/junit' # defaults to 'testresults/junit'
      file: 'junit-' # defaults to 'junit'
    html:  # set to false to omit this reporter
      dir: 'testresults/html' # defaults to 'testresults/html'
    spec:  # set to false to omit this reporter
      displayStacktrace: false # defaults to false

```

You can have all reports installed with their default values if you omit the corresponding options attribute. This means that if you just invoke *addJasmineReporters* without an argument all reporters will be added with their default values.

If you do not want to add certain reporter simply set the corresponding option attribute to *false*. For example if you do not want to use the HTML reporter do
```
  reporter.addJasmineReporters
    html: false
```

### To send results to your test results collection service
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
