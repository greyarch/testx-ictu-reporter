testx-ictu-reporter
=====

Simple test results reporter for ICTU quality system.

## Usage
```
  report = require 'testx-ictu-reporter'
  report 'http://path.to.trr.service', 'path/to/testresults.xml',
    appName: '[APP_NAME]'
    appVersion: '[APP_VERSION]'
    testDesc: '[TEST_DESCRIPTION]'
    testUser: '[TEST_USER]'
    testVersion: '[TEST_VERSION]'
    testTarget: '[TEST_TARGET]'
    testPlatform: '[TEST_PLATFORM]'
```
