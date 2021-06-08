require "../spec_helper"

describe Docker::Container do
  before_all { WebMock.reset }
  before_all { ENV["DOCKER_HOST"] = "tcp://localhost:80" }
  after_all { ENV.delete("DOCKER_HOST") }

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
      before_all do
        WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 404)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.start
        end
      end
    end

    context "server error" do
      before_all do
        WebMock.stub(:post, "localhost/containers/test/start").to_return(status: 500)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.start
        end
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
      before_all do
        WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 404)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.stop
        end
      end
    end

    context "server error" do
      before_all do
        WebMock.stub(:post, "localhost/containers/test/stop?t=5").to_return(status: 500)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.stop
        end
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
      before_all do
        WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 404)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.restart
        end
      end
    end

    context "server error" do
      before_all do
        WebMock.stub(:post, "localhost/containers/test/restart?t=5").to_return(status: 500)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.restart
        end
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
      before_all do
        WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 404)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.kill
        end
      end
    end

    context "server error" do
      before_all do
        WebMock.stub(:post, "localhost/containers/test/kill").to_return(status: 500)
      end
      it "raises error" do
        container = Docker::Container.from_json({"Id" => "test"}.to_json)
        expect_raises(Docker::Client::Exception) do
          container.kill
        end
      end
    end

  end

end
