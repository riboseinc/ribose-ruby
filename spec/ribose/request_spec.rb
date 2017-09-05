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

  describe ".post" do
    it "submits provided data via :post" do
      stub_ribose_ping_api_request(:post)
      response = Ribose::Request.post("ping", data: "hello")

      expect(response.data).to eq("Pong!")
    end
  end

  describe ".put" do
    it "creates a new http request via :put" do
      stub_ribose_ping_api_request(:put)
      response = Ribose::Request.put("ping", data: "hello")

      expect(response.data).to eq("Pong!")
    end
  end

  describe ".delete" do
    it "creates a http request via :delete" do
      stub_ribose_ping_api_request(:delete)
      response = Ribose::Request.delete("ping")

      expect(response.data).to eq("Pong!")
    end
  end

  def stub_ribose_ping_api_request(method = :get)
    stub_api_response(method, "ping", filename: "ping", status: 200)
  end
end
