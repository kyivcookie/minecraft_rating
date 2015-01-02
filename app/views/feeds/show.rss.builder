xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Minecraft Servers Ip'
    xml.description 'minecraftservers-ip.com'
    xml.link servers_url

    for post in @servers
      xml.item do
        xml.title post.name
        xml.description post.description
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "/servers/#{post.id}"
        xml.guid "/servers/#{post.id}"
        # xml.icon "/favicon.ico"
      end
    end
  end
end