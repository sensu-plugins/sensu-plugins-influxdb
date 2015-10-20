#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## Unreleased

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

## 0.0.1 - 2015-04-29

### Added
- initial release

## [0.0.2] - 2015-06-03

### Fixed
- added binstubs

### Changed
- removed cruft from /lib
