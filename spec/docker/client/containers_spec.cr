require "../../spec_helper"

describe Docker::Client::Containers do
  before { WebMock.reset }

  before { ENV["DOCKER_HOST"] = "tcp://localhost:1337" }
  after { ENV.delete "DOCKER_HOST" }

  describe ".containers" do
    before do
      WebMock
        .stub(:get, "http://localhost:1337/containers/json")
        .with(query: {
          "all" => "false", "limit" => "", "since" => "", "before" => "", "size" => "false", "filters" => "{}"
        })
        .to_return([
          { "Id" => "test1" },
          { "Id" => "test2" }
        ].to_json)
    end

    subject { Docker.client.containers }
    it "is a Array(Docker::Container)" do
      expect(subject).to be_a(Array(Docker::Container))
    end
  end
end
