require "spec_helper"

RSpec.describe Ribose::Client do
  describe "#new" do
    context "no attribtues provided" do
      it "initialize with default configuration" do
        client = Ribose::Client.new

        expect(client.api_token).to eq(Ribose.configuration.api_token)
        expect(client.user_email).to eq(Ribose.configuration.user_email)
      end
    end

    context "custom attribtues provided" do
      it "initialize with the supplied attribtues" do
        client = Ribose::Client.new(token: 123, email: "john@ex.com")

        expect(client.api_token).to eq("123")
        expect(client.user_email).to eq("john@ex.com")
      end
    end
  end
end
