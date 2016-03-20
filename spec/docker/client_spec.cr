require "../spec_helper"

describe Docker::Client do

  describe ".new" do

    context "defaults" do
      subject { Docker::Client.new }
      it "uses unix" do 
        expect(subject.url.to_s).to eq("unix:///var/run/docker.sock")
      end
    end

    context "env vars" do
      before { ENV["DOCKER_HOST"] = "tcp://0.0.0.0:8000" }
      after { ENV.delete("DOCKER_HOST") }
      subject { Docker::Client.new }
      it "applies environment" do 
        expect(subject.url.to_s).to eq("tcp://0.0.0.0:8000")
      end
    end

    context "manual setting" do
      subject { Docker::Client.new }
      before { subject.url = "tcp://0.0.0.0:8001" }
      it "applies custom setting" do 
        expect(subject.url.to_s).to eq("tcp://0.0.0.0:8001")
      end
    end

  end

end
