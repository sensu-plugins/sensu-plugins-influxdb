#! /usr/bin/env ruby
#
#   metrics-influx.rb
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
  option :config,
         description: 'Configuration information to use',
         short: '-c CONFIG',
         long: '--config CONFIG',
         default: 'influxdb'

  def filter; end

  def create_point(series, value, time)
    point = { series: series,
              tags: { host: @event['client']['name'], metric: @event['check']['name'] },
              values: { value: value },
              timestamp: time }
    point[:tags].merge!(@event['check']['tags']) unless @event['check']['tags'].nil?
    point
  end

  def parse_output
    data = []
    metric_raw = @event['check']['output']
    metric_raw.split("\n").each do |metric|
      m = metric.split
      next unless m.count == 3
      key = m[0].split('.', 2)[1]
      key.tr!('.', '_')
      value = m[1].to_f
      time = m[2]
      point = create_point(key, value, time)
      data.push(point)
    end
    data
  end

  def check_status
    data = []
    data.push(create_point(@event['check']['name'], @event['check']['status'], @event['client']['timestamp']))
  end

  def handle
    opts = settings[config[:config]].each_with_object({}) do |(k, v), sym|
      sym[k.to_sym] = v
    end
    database = opts[:database]

    influxdb_data = InfluxDB::Client.new database, opts
    influxdb_data.create_database(database) # Ensure the database exists

    data = if opts[:status] == false || opts[:status].nil?
             parse_output
           else
             check_status
           end
    influxdb_data.write_points(data)
  end
end
