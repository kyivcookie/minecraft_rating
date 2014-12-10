require 'json'

module ServersHelper
end

module McStatus
  # class ServerUpdater
  #
  #   def initialize(host, port=25565, protocol = 0)
  #     @script_location = File.expand_path('..\..\lib\server_ping.php', File.dirname(__FILE__))
  #     @host = host
  #     @port = port
  #     @protocol = protocol
  #   end
  #
  #   def ping
  #     start = Time.now
  #     ping = get_ping_data(@host)
  #
  #     unless ping.nil?
  #       [
  #           :version_name => ping["version"]["name"],
  #           :max_players => ping["players"]["max"],
  #           :players_online => ping["players"]["online"],
  #           :created_at => start
  #       ]
  #     end
  #   end
  # end

  class ServerUpdater < Struct.new(:servers)
    def update!
      script_location = File.expand_path('..\..\lib\server_ping.php', File.dirname(__FILE__))

      self.servers.each do |server|
        ping = get_ping_data(server, script_location)
        time = Time.now.to_i

        if server.serversuptime.nil?
          uptime = Serversuptime.new
          uptime.server_id = server.id
          uptime.down = 0
          uptime.up = 0

          uptime.save!
        else
          uptime = server.serversuptime
        end

        if ping.nil?
          server.update(
              {
                  status: 0,
                  cache_time: time
              }
          )
          uptime.increment! :down
        else
          server.update(
              {
                  status: 1,
                  server_version: ping["version"]["name"],
                  players: ping["players"]["online"],
                  max_players: ping["players"]["max"],
                  cache_time: time
              }
          )
          uptime.increment! :up
        end
      end
    end
  end
end

# Minimal version of PHP is 5.3.0 for f-n json_last_error() provided in this version
# OS detect for dev

private

def get_ping_data(server, location)
  begin
    if ENV['OS'] == 'Windows_NT'
      JSON.parse(`php "#{location}" "#{server.ip}"`)
    else
      JSON.parse(`php54 "/home/unrealm/webapps/minecraft_rating/current/lib/server_ping.php" "#{server.ip}"`)
    end
  rescue JSON::ParserError => e
    nil
  end
end