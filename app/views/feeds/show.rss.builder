xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Minecraft Servers Ip'
    xml.description 'minecraftservers-ip.com'
    xml.link servers_url

    for server in @servers
      xml.item do
        xml.title server.name
        xml.description "<![CDATA[ <img src='http://#{request.host_with_port}/servers/#{server.id}/banner'> #{server.description} ]]>"
        xml.pubDate server.created_at.to_s(:rfc822)
        xml.link server_url server
        xml.guid server_url server
        # xml.icon "/favicon.ico"
      end
    end
  end
end