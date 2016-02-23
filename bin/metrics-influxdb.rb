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
  def filter; end

  def handle
    opts = settings['influxdb'].each_with_object({}) do |(k, v), sym|
      sym[k.to_sym] = v
    end

    database = opts[:database]

    influxdb_data = InfluxDB::Client.new database, opts

    client_name = @event['client']['name']
    metric_name = @event['check']['name']

    metric_raw = @event['check']['output']
    tags = @event['check']['tags']

    data = []
    metric_raw.split("\n").each do |metric|
      m = metric.split
      next unless m.count >= 3
      key = m[0].split('.', 2)[1]
      key.tr!('.', '_')
      value = m[1].to_f
      time = m[2]
      custom_tags = { }
      custom_tags_raw = m[3..-1]
      custom_tags_raw.each do |custom_tag|
        t = custom_tag.split('=')
        next unless t.count == 2
        custom_tags[t[0]] = t[1]
      end
      point = { series: key,
                tags: { host: client_name, metric: metric_name },
                values: { value: value },
                timestamp: time
              }
      point[:tags].merge!(tags) unless tags.nil?
      point[:tags].merge!(custom_tags) unless custom_tags.nil?
      data.push(point)
    end
    influxdb_data.write_points(data)
  end
end
