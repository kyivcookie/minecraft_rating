require 'socket'
require 'minecraft-query'

module ServersHelper
  def connect(ip,port)
    Query::fullQuery(ip, 25565);
  end
end


