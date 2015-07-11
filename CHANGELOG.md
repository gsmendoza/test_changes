## master

* Update slop to 4.2.

## 0.3.1

### Bug fixes

* Fix: throws error if a runner doesn't have exclusion patterns.
* Fix: FindingPattern should require pathname.

## 0.3.0

### Breaking changes

* Reintroduced finding_patterns option in config file. See README for more info.

### New features

* You can now list files that should be excluded when running a command.
* You can now specify glob patterns as substitution patterns.

## 0.2.0

### Breaking changes

* Command line API changed. See README and `test-changes -h` for more information. #4
* Config file renamed to `test-changes.yml`. #4
* Config file format changed. See README for more info. #4

### New features

* You can now put multiple runners in the config file. #8

## 0.1.1

* Infer configuration automatically (#2 @rstacruz).

## 0.1.0

* First release.
