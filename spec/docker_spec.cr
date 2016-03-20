require "./spec_helper"

describe Docker do

  describe ".client" do
    it "is a Docker::Client" do
      expect(Docker.client).to be_a(Docker::Client)
    end
  end

end
