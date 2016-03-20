require "../spec_helper"

describe Docker::Container do
  before { WebMock.reset }
  before { ENV["DOCKER_HOST"] = "tcp://localhost:80" }
  after { ENV.delete("DOCKER_HOST") }
  subject { Docker::Container.from_json({"Id" => "test"}.to_json) }

  describe "#start" do

    # TODO: Find a way to test those.

    # context "success" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 204)
    #   end
    #   it "returns itself" do
    #     expect(subject.start).to be(subject)
    #   end
    # end

    # context "already started" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 304)
    #   end
    #   it "returns itself" do
    #     expect(subject.start).to be(subject)
    #   end
    # end

    context "not found" do
      before do
        WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 404)
      end
      it "raises error" do
        expect { subject.start }.to raise_error(Docker::Client::Exception)
      end
    end

    context "server error" do
      before do
        WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 500)
      end
      it "raises error" do
        expect { subject.start }.to raise_error(Docker::Client::Exception)
      end
    end

  end

  describe "#stop" do

    # TODO: Find a way to test those.

    # context "success" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 204)
    #   end
    #   it "returns itself" do
    #     expect(subject.stop).to be(subject)
    #   end
    # end

    # context "already stoped" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 304)
    #   end
    #   it "returns itself" do
    #     expect(subject.stop).to be(subject)
    #   end
    # end

    context "not found" do
      before do
        WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 404)
      end
      it "raises error" do
        expect { subject.stop }.to raise_error(Docker::Client::Exception)
      end
    end

    context "server error" do
      before do
        WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 500)
      end
      it "raises error" do
        expect { subject.stop }.to raise_error(Docker::Client::Exception)
      end
    end
  end

  describe "#restart" do

    # TODO: Find a way to test those.

    # context "success" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 204)
    #   end
    #   it "returns itself" do
    #     expect(subject.restart).to be(subject)
    #   end
    # end

    # context "already restarted" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 304)
    #   end
    #   it "returns itself" do
    #     expect(subject.restart).to be(subject)
    #   end
    # end

    context "not found" do
      before do
        WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 404)
      end
      it "raises error" do
        expect { subject.restart }.to raise_error(Docker::Client::Exception)
      end
    end

    context "server error" do
      before do
        WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 500)
      end
      it "raises error" do
        expect { subject.restart }.to raise_error(Docker::Client::Exception)
      end
    end
  end

  describe "#kill" do

    # TODO: Find a way to test those.

    # context "success" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 204)
    #   end
    #   it "returns itself" do
    #     expect(subject.kill).to be(subject)
    #   end
    # end

    # context "already killed" do
    #   before do
    #     WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 304)
    #   end
    #   it "returns itself" do
    #     expect(subject.kill).to be(subject)
    #   end
    # end

    context "not found" do
      before do
        WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 404)
      end
      it "raises error" do
        expect { subject.kill }.to raise_error(Docker::Client::Exception)
      end
    end

    context "server error" do
      before do
        WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 500)
      end
      it "raises error" do
        expect { subject.kill }.to raise_error(Docker::Client::Exception)
      end
    end

  end

end