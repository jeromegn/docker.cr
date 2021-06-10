require "./spec_helper"

describe Docker do

  describe ".client" do
    it "is a Docker::Client" do
      Docker.client.should be_a(Docker::Client)
    end
  end

end
