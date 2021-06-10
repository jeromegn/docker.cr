require "../../spec_helper"

describe Docker::Client::Info do
  before_all { WebMock.reset }

  before_all { ENV["DOCKER_HOST"] = "tcp://localhost:1337" }
  after_all { ENV.delete "DOCKER_HOST" }

  describe "#info" do
    before_all { WebMock.stub(:get, "http://localhost:1337/info").to_return({"Containers" => 30}.to_json) }

    it "is a Docker::Info" do
      info = Docker.client.info
      info.should be_a(Docker::Info)
    end
  end

end
