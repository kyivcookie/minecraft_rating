require 'json'

module ServersHelper
end

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

    unless ping.nil?
      [
          :version_name => ping["version"]["name"],
          :max_players => ping["players"]["max"],
          :players_online => ping["players"]["online"],
          :created_at => start
      ]
    end
  end
end

# Minimal version of PHP is 5.3.0 for f-n json_last_error() provided in this version
# OS detect for dev

private

def get_ping_data(server)
  begin
    if ENV['OS'] == 'Windows_NT'
      JSON.parse(`php "#{@script_location}" "#{@host}"`)
    else
      JSON.parse(`php54 "/home/unrealm/webapps/minecraft_rating/current/lib/server_ping.php" "#{@host}"`)
    end
  rescue JSON::ParserError => e
    nil
  end
end