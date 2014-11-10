require 'json'

# require_relative '../models/ping'


  # class ServerUpdater
  #   @@script_location = File.expand_path("server_ping.php", File.dirname(__FILE__))
  #
  #   def initialize(host, port=25565, protocol = 0)
  #     @host = host
  #     @port = port
  #     @protocol = protocol
  #   end
  #
  #   def ping
  #     start = Time.now
  #       ping = get_ping_data(server)
  #
  #        unless ping.nil?
  #         [
  #           :server => server,
  #           :version_name => ping["version"]["name"],
  #           :max_players => ping["players"]["max"],
  #           :players_online => ping["players"]["online"],
  #           :created_at => start
  #         ]
  #       end
  #     end
  #   end
  #
  #   private
  #
  #   def get_ping_data(server)
  #     begin
  #       JSON.parse(`php "#{@@script_location}" "biocraft.co"`)
  #     rescue JSON::ParserError => e
  #       nil
  #     end
  #   end


