## Sensu-Plugins-influxdb

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-influxdb.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-influxdb)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-influxdb.svg)](http://badge.fury.io/rb/sensu-plugins-influxdb)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-influxdb.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-influxdb)

## Functionality

## Files
 * bin/check-influxdb
 * bin/check-influxdb-query
 * bin/metrics-influxdb

## Usage

**metrics-influxdb**
```
{
    "influxdb"   : {
               "server"      : "influxdb.familyguy.com",
               "port"        : "8086",
               "username"    : "root",
               "password"    : "root",
               "database"    : "stats"
     }
}
```

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-influxdb -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-influxdb`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-influxdb' do
  options('--prerelease')
  version '0.0.1.alpha.4'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-influxdb' do
  options('--prerelease')
  version '0.0.1.alpha.4'
end
```

## Notes

[1]:[https://travis-ci.org/sensu-plugins/sensu-plugins-influxdb]
[2]:[http://badge.fury.io/rb/sensu-plugins-influxdb]
[3]:[https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb]
[4]:[https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb]
[5]:[https://gemnasium.com/sensu-plugins/sensu-plugins-influxdb]
