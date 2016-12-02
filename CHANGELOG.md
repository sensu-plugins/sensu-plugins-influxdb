#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]

## [1.1.0] - 2016-12-01
### Added
- Added tags support for mutator-influxdb-line-protocol.rb 
- Added retry support for check-influxdb-query.rb - The InfluxDB gem by default retries indefinitely and will cause the query to hang.  A retry of 12 will retry for approx 37 seconds.

### Changed
- Update to `influxdb` gem 0.3.13

## [1.0.0] - 2016-10-06
### Added
- Ruby 2.3.0 support

### Removed
- Ruby 1.9.3 support

### Changed
- Update `influxdb` dep to 0.3.10
- Update `dentaku` dep to 2.0.9
- Update `sensu-plugin` dep to ~> 1.3
- Update `jsonpath` dep to 0.5.8
- Update to rubocop 0.40 and cleanup

### [0.0.7] - 2016-04-26
- Line protocol mutator extension
- added tags support for metrics-influxdb.rb
- Fixed option tag in check-influxdb-query
- added support for storing check status for metrics-influxdb.rb
- metrics-influxdb.rb will now create the database if needed
- metrics-influxdb.rb can now be configured to use a specific settings block

### [0.0.6] - 2016-04-18
- supress warning if only checking for an existing return value in check-influxdb-query.

### [0.0.5] - 2015-10-19
- added support for https in check-influxdb.
- pass ssl arguments to the influxdb object in check-influxdb-query.
- renamed the config option in check-influxdb from ssl to verify_ssl.
- changed README to update the config option ssl_ca_cert.

### [0.0.4] - 2015-08-10
- updated metrics-influxdb.rb to symbolize keys for InfluxDB::Client
- updated influxdb gem to 0.2.2
- updated metrics-influxdb.rb to support influxdb 0.9.x
- updated check-influxdb.rb and check-influxdb-query.rb to support influxdb 0.9.x
- updated README.md file

## [0.0.3] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.2] - 2015-06-03
### Fixed
- added binstubs

### Changed
- removed cruft from /lib

## 0.0.1 - 2015-04-29
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/1.1.0...HEAD
[1.1.0]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.7...1.0.0
[0.0.7]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.6...0.0.7
[0.0.6]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.5...0.0.6
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.1...0.0.2
