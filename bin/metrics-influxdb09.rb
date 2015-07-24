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
require 'influxdb'

#
# Sensu To Influxdb
#
class SensuToInfluxDB < Sensu::Handler
  def filter; end

  def handle
    influxdb_server = settings['influxdb']['server']
    influxdb_port   = settings['influxdb']['port']
    influxdb_user   = settings['influxdb']['username']
    influxdb_pass   = settings['influxdb']['password']
    influxdb_db     = settings['influxdb']['database']
    influxdb_time_p = settings['influxdb']['time_precision']

    influxdb_data = InfluxDB::Client.new influxdb_db, host: influxdb_server,
                                                      username: influxdb_user,
                                                      password: influxdb_pass,
                                                      port: influxdb_port
                                                      time_precision: influxdb_time_p
                                                      
    client_name = @event['client']['name']
    metric_name = @event['check']['name']
    
    metric_raw = @event['check']['output']
    
    mydata = metric_raw.split("\n")
      .map(&:split)
      .select { |(*x)| x.length==3 }
      .map do |(k, v, time)|
        {
          series: k,
          tags: { host: client_name, metric: metric_name },
          values: { value: v },
          timestamp: time
        }
      end
    
    influxdb_data.write_points(mydata, influxdb_time_p)

  end
end
