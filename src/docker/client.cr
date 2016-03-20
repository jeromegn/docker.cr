require "socket"
require "uri"

module Docker
  class Client

    delegate :get, :post, :put, :patch, :head, client

    DEFAULT_URL = "unix:///var/run/docker.sock"
    DEFAULT_CERT_PATH = "#{ENV["HOME"]}/.docker"

    def initialize(url = ENV.fetch("DOCKER_URL", ENV.fetch("DOCKER_HOST", DEFAULT_URL)))
      @url = URI.parse(url)
    end

    def client
      if unix?
        HTTP::Client.unix(@url.to_s.sub(/^unix:\/\//, ""))
      elsif verify_tls?
        c = HTTP::Client.new(@url.host.not_nil!, @url.port.not_nil!, true)
        c.ssl_context = ssl_context
        c
      else
        HTTP::Client.new(@url.host.not_nil!, @url.port.not_nil!, false)
      end
    end

    def info
      Docker::Info.from_json(client.get("/info").body)
    end

    private def ssl_context
      @ssl_context ||= begin
        ctx = OpenSSL::SSL::Context.new(LibSSL.tlsv1_method)
        ctx.private_key = key_file_path
        ctx.ca_file = ca_file_path
        ctx.certificate_file = cert_file_path
        ctx
      end
    end

    private def verify_tls?
      tcp? && !!ENV.fetch("DOCKER_TLS_VERIFY", "0")
    end

    private def unix?
      @url.scheme == "unix"
    end

    private def tcp?
      @url.scheme == "tcp" || @url.scheme == "http" || @url.scheme == "https"
    end

    private def cert_path
      ENV.fetch("DOCKER_CERT_PATH", DEFAULT_CERT_PATH)
    end

    private def ca_file_path
      "#{cert_path}/ca.pem"
    end

    private def key_file_path
      "#{cert_path}/key.pem"
    end

    private def cert_file_path
      "#{cert_path}/cert.pem"
    end

  end
end