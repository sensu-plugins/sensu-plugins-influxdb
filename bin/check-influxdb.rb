#! /usr/bin/env ruby
#
#   check-influx
#
# DESCRIPTION:
#   Check if /ping endopoint is responding
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright (C) 2014, Mitsutoshi Aoe <maoe@foldr.in>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/check/cli'
require 'net/https'

#
# Check InfluxDB
#
class CheckInfluxDB < Sensu::Plugin::Check::CLI
  option :host,
         description: 'Host address of the InfluxDB server',
         short: '-h HOST',
         long: '--host HOST',
         default: 'localhost'

  option :port,
         description: 'Port number of the InfluxDB server',
         short: '-p PORT',
         long: '--port PORT',
         proc: proc(&:to_i),
         default: 8086

  option :use_ssl,
         description: 'Turn on/off SSL (default: false)',
         short: '-s',
         long: '--use_ssl',
         boolean: true,
         default: false

  option :verify_ssl,
         description: 'Turn on/off using SSL certificate (default: false)',
         short: '-v',
         long: '--verify_ssl',
         boolean: true,
         default: false

  option :ssl_ca_cert,
         description: 'Path to the ssl ca certificate to connect to the InfluxDB server',
         short: '-c CA_CERT',
         long: '--ssl_ca_cert CA_CERT'

  option :timeout,
         description: 'Seconds to wait for the connection to open or read (default: 1.0s)',
         short: '-t SECONDS',
         long: '--timeout SECONDS',
         proc: proc(&:to_f),
         default: 1.0

  def run
    http = Net::HTTP.new(config[:host], config[:port])
    http.open_timeout = config[:timeout]
    http.read_timeout = config[:timeout]
    http.use_ssl = config[:use_ssl]
    if config[:verify_ssl]
      http.ca_file = config[:ssl_ca_cert]
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    else
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    http.start do
      response = http.get('/ping')
      status_line = "#{response.code} #{response.message}"
      if response.is_a?(Net::HTTPSuccess)
        ok status_line
      else
        critical status_line
      end
    end
  rescue => e
    critical e.to_s
  end
end
