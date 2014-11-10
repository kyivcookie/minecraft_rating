require 'json'

module ServersHelper
end


# require_relative '../models/ping'
class ServerUpdater

  def initialize(host, port=25565, protocol = 0)
    @script_location = File.expand_path('..\..\lib\server_ping.php', File.dirname(__FILE__))
    @host = host
    @port = port
    @protocol = protocol
  end

  def ping
    start = Time.now
    ping = get_ping_data(@host)
    raise ping.inspect
    unless ping.nil?
      [
          # :server => 'asd',
          :version_name => ping["version"]["name"],
          :max_players => ping["players"]["max"],
          :players_online => ping["players"]["online"],
          :created_at => start
      ]
    end
  end
end

private

def get_ping_data(server)
  begin
    JSON.parse(`php54 "#{@script_location}" "titanmc.net"`)
  rescue JSON::ParserError => e
    nil
  end
end