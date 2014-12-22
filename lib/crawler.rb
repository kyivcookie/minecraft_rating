require 'nokogiri'
require 'net/http'

module Crawler

  def self.call(start, stop)
    (start..stop).each do |server_id|
      puts '=' * 80
      mcs = MineCraftServer.new(server_id)

      if mcs.skip?
        puts 'skip'
      else
        puts "server: #{server_id}"
        puts "name: #{mcs.name}"
        puts "country: #{mcs.country}"
        puts "ip: #{mcs.ip}"
        puts "description: #{mcs.description}"
        puts "tags: #{mcs.tags.join(', ')}"
        puts "image length: #{mcs.image.length}"
        puts "website: #{mcs.website}"

        server = Server.find_or_create_by(name: mcs.name)
        server.banner = mcs.image
        server.ip = mcs.ip
        server.description = mcs.description
        server.country = mcs.country
        server.port = 80
        server.website = mcs.website
        server.save!
        mcs.tags.each do |name|
          stc = ServersToCategories.create!(server_id: server.id, category_id: Category.find_or_create_by(name: name).id)
        end
      end

      puts '=' * 80
      sleep(5.minutes)
    end
  end

  class MineCraftServer

    def initialize(server_id, host='http://minecraftservers.org')
      @response = Net::HTTP.get_response((URI("#{host}/server/#{server_id}")))
      @host = host
    end

    def skip?
      !@response.code.to_i.eql?(200)
    end

    def name
      doc.xpath('//div[@class="section-head"]/h1').text.strip
    end

    def country
      doc.xpath('//td[text()="Country"]/following-sibling::td[1]').text.strip
    end

    def tags
      doc.xpath('//td[@class="tags"]/a').map(&:text).map(&:strip)
    end

    def description
      doc.xpath('//p[@class="desc"]').text.strip
    end

    def website
      doc.xpath('//td[text()="Website"]/following-sibling::td[1]').text.strip
    end

    def image
      file = Pathname(doc.xpath('//div[@id="info"]/img').attr('src').value)
      CarrierWaveStringIO.new(Net::HTTP.get_response(URI("#{@host}/#{file.to_s}")).body).tap do |string_io|
        string_io.original_filename = file.basename.to_s
      end
    end

    def ip
      doc.xpath('//td[text()="IP"]/following-sibling::td[1]').text.strip
    end

    protected

    def doc
      @doc ||= Nokogiri::HTML(@response.body)
    end

  end

  class CarrierWaveStringIO < StringIO
    attr_accessor :original_filename
  end

end