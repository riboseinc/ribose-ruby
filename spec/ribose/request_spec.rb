require "spec_helper"

RSpec.describe Ribose::Request do
  describe ".get" do
    it "retrieve the resource via a http :get" do
      endpoint = "ping"

      stub_ribose_ping_api_request
      response = Ribose::Request.get(endpoint)

      expect(response.data["data"]).to eq("Pong!")
    end
  end

  def stub_ribose_ping_api_request
    stub_request(:get, "https://www.ribose.com/ping").
      with(headers: { "Accept" => "application/json" }).
      to_return(status: 200, body: "{ \"data\": \"Pong!\" }")
  end
end
