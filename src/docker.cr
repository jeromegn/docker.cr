require "json"
require "openssl"
require "http"
require "./core_ext/**"
require "./docker/*"

module Docker
  extend self

  def client
    Docker::Client.new
  end

  def info
    Docker::Info.new
  end
end
