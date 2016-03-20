require "../../spec_helper"

describe Docker::Client::Info do
  before { WebMock.reset }

  before { ENV["DOCKER_HOST"] = "tcp://localhost:1337" }
  after { ENV.delete "DOCKER_HOST" }

  describe ".info" do
    before { WebMock.stub(:get, "http://localhost:1337/info").to_return({"Containers" => 30}.to_json) }

    subject { Docker.client.info }
    it "is a Docker::Info" do
      expect(subject).to be_a(Docker::Info)
    end
  end

end