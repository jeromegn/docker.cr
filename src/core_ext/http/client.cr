class HTTP::Client

  def ssl_context=(ctx : OpenSSL::SSL::Context)
    self.socket = OpenSSL::SSL::Socket.new(tcp_socket, :client, ctx)
  end

  def self.unix(path)
    client = new("localhost")
    client.socket = UNIXSocket.new(path)
    client
  end

  def socket
    @socket ||= if @ssl
      @ssl_socket ||= OpenSSL::SSL::Socket.new(tcp_socket)
    else
      tcp_socket
    end
  end

  def socket=(socket : IO)
    @socket = socket
  end

  private def tcp_socket
    socket = TCPSocket.new @host, @port, @dns_timeout, @connect_timeout
    socket.read_timeout = @read_timeout if @read_timeout
    socket.sync = false
    socket
  end

end