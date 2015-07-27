#! /usr/bin/env ruby
#
#   metrics-influx09.rb
#
# DESCRIPTION:
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: influxdb
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright (C) 2015, Sensu Plugins
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-handler'
gem 'influxdb', '>=0.2.0'
require 'influxdb'

#
# Sensu To Influxdb
#
class SensuToInfluxDB < Sensu::Handler
  def filter; end

  def handle
    opts = settings['influxdb']
    database = opts['database']

    influxdb_data = InfluxDB::Client.new database, opts

    client_name = @event['client']['name']
    metric_name = @event['check']['name']

    metric_raw = @event['check']['output']

    data = []
    metric_raw.split("\n").each do |metric|
      m = metric.split
      next unless m.count == 3
      key = m[0].split('.', 2)[1]
      key.gsub!('.', '_')
      value = m[1].to_f
      time = m[2]
      point = { series: key,
                tags: { host: client_name, metric: metric_name },
                values: { value: value },
                timestamp: time
              }
      data.push(point)
    end
    
    influxdb_data.write_points(data)

  end
end
