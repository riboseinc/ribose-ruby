require "spec_helper"

RSpec.describe Ribose::Request do
  describe ".get" do
    it "retrieve the resource via a http :get" do
      endpoint = "ping"

      stub_ribose_ping_api_request
      response = Ribose::Request.get(endpoint)

      expect(response.data).to eq("Pong!")
    end
  end

  def stub_ribose_ping_api_request
    stub_api_response(:get, "ping", filename: "ping", status: 200)
  end
end
