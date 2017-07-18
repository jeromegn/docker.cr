class HTTP::Client
  include OpenSSL

  @socket : UNIXSocket | TCPSocket | SSL::Socket | Nil

  def ssl_context=(ctx : SSL::Context)
    self.socket = SSL::Socket::Client.new(tcp_socket, ctx.as(SSL::Context::Client))
  end

  def self.unix(path)
    client = new("localhost")
    client.socket = UNIXSocket.new(path)
    client
  end

  def socket
    @socket ||= if @tls
      @ssl_socket ||= SSL::Socket::Client.new(tcp_socket)
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
