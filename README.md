## Sensu-Plugins-influxdb

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-influxdb.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-influxdb)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-influxdb.svg)](http://badge.fury.io/rb/sensu-plugins-influxdb)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-influxdb)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-influxdb.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-influxdb)

## Functionality

## Files
 * bin/check-influxdb.rb
 * bin/check-influxdb-query.rb
 * bin/metrics-influxdb.rb

## Usage
Add the following to `/etc/sensu/conf.d/influx.conf` "plugin expects `influxdb` to be a top level node in the json
**metrics-influxdb**
```
{
    "influxdb": {
        "hosts"         : ["influxdb.familyguy.com"],
        "host"          : "influxdb.familyguy.com",
        "port"          : "8086",
        "username"      : "root",
        "password"      : "root",
        "database"      : "stats",
        # OPTIONAL
        "time_precision": "s",
        "use_ssl"       : false,
        "verify_ssl"    : true,
        "ssl_ca_cert"   : "path to the ca certificate file",
        "auth_method"   : "params",
        "initial_delay" : 0.01,
        "max_delay"     : 30,
        "open_timeout"  : 5,
        "read_timeout"  : 300,
        "retry"         : null,
        "prefix"        : "",
        "denormalize"   : true,
        "status"        : true
    }
}
```
Then add the following to you `/ect/sensu/conf.d/handlers.conf`:
```
{
  "handlers": {
     "influx-tcp": {
       "type": "pipe",
       "command": "/opt/sensu/embedded/bin/metrics-influxdb.rb"
     }
   }
}
```
To ship additional tags to your metrics via metrics-influxdb.rb (only available in influxdb >= 0.9), just add a tags block inside your check.

Setting "status" to true will store the metric using the status as the value and the check name as the series

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes
