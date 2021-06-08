require "../../spec_helper"

describe Docker::Client::Containers do
  before_all { WebMock.reset }

  before_all { ENV["DOCKER_HOST"] = "tcp://localhost:1337" }
  after_all { ENV.delete "DOCKER_HOST" }

  describe ".containers" do
    before_all do
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

    it "is a Array(Docker::Container)" do
      containers = Docker.client.containers
      containers.should be_a(Array(Docker::Container))
    end
  end
end
