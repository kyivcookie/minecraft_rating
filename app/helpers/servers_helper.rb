module ServersHelper
  def connect(ip, port)
    Query::simpleQuery(ip, port)
  end
end


