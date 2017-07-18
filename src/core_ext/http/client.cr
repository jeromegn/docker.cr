class HTTP::Client
  @socket : UNIXSocket | TCPSocket | OpenSSL::SSL::Socket | Nil

  def ssl_context=(ctx : OpenSSL::SSL::Context)
    self.socket = OpenSSL::SSL::Socket::Client.new(tcp_socket, ctx.as(OpenSSL::SSL::Context::Client))
  end

  def self.unix(path)
    client = new("localhost")
    client.socket = UNIXSocket.new(path)
    client
  end

  def socket
    @socket ||= if @tls
      @ssl_socket ||= OpenSSL::SSL::Socket::Client.new(tcp_socket)
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
