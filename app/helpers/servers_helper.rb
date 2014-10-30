# require 'socket'
module ServersHelper
end

##
# Pings a minecraft server and returns motd and playercount.
# Works with ruby >=1.9.3/2.0.0
#
# More information and sample code here:
# http://wiki.vg/Server_List_Ping
##
class MinecraftPing
  def initialize(host, port=25565, protocol = 0)
    @host = host
    @port = port
    @protocol = protocol
  end

  def check_protocol
    if new_query
      2
    else
      if old_query
        1
      else
        0
      end
    end
  end

  def check
    # if @protocol > 1
    #   new_query
    # else
    #   old_query
    # end
    # new_query
    nil
  end

  def new_query
    request = [
        "\x00\x04",
        [@host.size].pack('c'),
        @host,
        [@port].pack('n'),
        "\x01"].join

    request = [request.size].pack('c') + request
    socket =  TCPSocket.open(@host, @port)

    socket.write(request)
    socket.write("\x01\x00")

    begin
      timeout(10) do
        text = socket.read.force_encoding('ISO-8859-15').encode('UTF-8')
        text = (JSON.parse text[5, text.length]).symbolize_keys
        cl = ''
        text[:description]['text'].each_byte { |x|  cl << x unless x > 128   }
        # raise  text[:version][:name].inspect
        {
            :protocol => text[:version]['protocol'],
            :minecraft_version => text[:version]['name'],
            :motd => cl,
            :current_players => text[:players]['online'],
            :max_players => text[:players]['max']
        }
      end
    end
    rescue StandardError => e
      nil
  end



  def old_query
    socket = TCPSocket.open(@host, @port)
    # packet identifier & payload ...
    socket.write([0xFE, 0x01, 0xFA].pack('CCC'))
    socket.write(encode_string('MC|PingHost'))
    socket.write([7 + 2 * @host.length].pack('n'))
    socket.write([74].pack('c'))
    socket.write(encode_string(@host))
    socket.write([@port].pack('N'))

    begin
      timeout(1) do
        # read server response
        if socket.read(1).unpack('C').first != 0xFF # Kick packet
          raise 'unexpected server response packet'
        end

        len = socket.read(2).unpack('n').first
        resp = decode_string(socket.read(len*2)).split("\u0000")

        socket.close

        if resp.shift != "\u00A71"
          raise 'unexpected server response fields'
        end

        protocol = resp.shift.to_i
        version = resp.shift
        motd = resp.shift.gsub!(/(§.)/, '')
        players = resp.shift.to_i
        max_players = resp.shift.to_i

        return {
            :protocol => protocol,
            :minecraft_version => version,
            :motd => motd,
            :current_players => players,
            :max_players => max_players
        }
      end
    end
    rescue StandardError => e
      return nil
  end

  private

  def encode_string(s)
    begin
      [s.length].pack('n') + Iconv.conv('utf-16be', 'utf-8', s)
    rescue
      [s.length].pack('n') + s.encode('utf-16be').force_encoding('ASCII-8BIT')
    end
  end

  def read_var(socket)
    i = 0
    j = 0

    while true
      k = socket.read

      if k === FALSE
        return 0
      end

      k = k.ord

      i |= ( k & 0x7f ) << (j+1) * 7

      if j > 5
        return false
      end

      if (k & 0x80) != 128
        break
      end
    end

    i
  end

  def decode_string(s)
    begin
      Iconv.conv('utf-8', 'utf-16be', s)
    rescue
      s.force_encoding('utf-16be').encode('utf-8')
    end
  end
end