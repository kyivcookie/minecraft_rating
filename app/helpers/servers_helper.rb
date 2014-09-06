require 'socket'
# require 'IO'

module ServersHelper
  def connect(ip,port)
    @ip = ip
    @port = port
    @socket = TCPSocket.open ip, port

    self.create_new_query
  end

  def create_new_query
    data = "\x00"
    data += "\x04"
    data += [@ip.mb_chars.length].pack('c') + @ip
    data += [@port].pack('n')
    data += "\x01"
    data = [data.mb_chars.length].pack('c') + data

    @socket.send(data,1)
    @socket.send("\x01\x00",1)
    self.getline

    # data = ''
    #
    # while data.length < length
    #   r = length - data.length
    #   data += read(@socket, r)
    # end

    # puts data
    @socket.close
  end

  def getline
    begin
      line = @socket.readline # if get EOF, raise EOFError
      line.sub!(/(\r\n|\n|\r)\z/n, "")
        print "get: ", sanitize(line), "\n"
      return line
    end
    rescue EOFError
  end

  def readline
    i = 0
    j = 0

    while true
      k = @socket.readline

      print k

      if k === FALSE
        return 0
      end

      k = k.ord

      i |= (k & 0x7f) << j * 7

      if j > 5
        throw new Exception 'Line too big'
      end

      if (k & 0x80) != 128
        break
      end
    end
    i
  end
end


