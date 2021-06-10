require "../spec_helper"

describe Docker::Client do

  describe ".new" do

    context "defaults" do
      it "uses unix" do 
        client = Docker::Client.new
        client.url.to_s.should eq("unix:///var/run/docker.sock")
      end
    end

    context "env vars" do
      before_all { ENV["DOCKER_HOST"] = "tcp://0.0.0.0:8000" }
      after_all { ENV.delete("DOCKER_HOST") }
      it "applies environment" do 
        client = Docker::Client.new
        client.url.to_s.should eq("tcp://0.0.0.0:8000")
      end
    end

    context "manual setting" do
      it "applies custom setting" do 
        client = Docker::Client.new
        client.url = "tcp://0.0.0.0:8001"
        client.url.to_s.should eq("tcp://0.0.0.0:8001")
      end
    end

  end

end
