#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
- Line protocol mutator extension
- added tags support for metrics-influxdb.rb
- Fixed option tag in check-influxdb-query
- added support for storing check status for metrics-influxdb.rb
- metrics-influxdb.rb will now create the database if needed
- metrics-influxdb.rb can now be configured to use a specific settings block

### [0.0.6] - 2016-04-18
- renamed config options flags (host, port and ssl_ca_cert) in check-influxdb-query.

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

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.5...HEAD
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-influxdb/compare/0.0.1...0.0.2
