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

  describe "client" do
    context "when custom client specifeid" do
      it "sends the http request with the custom client" do
        client = Ribose::Client.new(token: 123, email: "john@example.com")

        stub_ribose_ping_api_request(:get, client)
        response = Ribose::Request.get("ping", client: client)

        expect(response.data).to eq("Pong!")
      end
    end

    context "with invalid ribose client" do
      it "raise the ribose unauthorized error" do
        expect do
          Ribose::Request.get("ping", client: Hash.new)
        end.to raise_error(Ribose::Unauthorized)
      end
    end
  end

  example "custom Faraday options from configuration are used" do
    custom_headers = {"X-Set-In-Config" => "Yes"}

    stub_configuration do |config|
      config.faraday_options = {headers: custom_headers}
    end

    stub_ribose_ping_api_request(:get)
    Ribose::Request.get("ping")

    expect(
      a_request(:any, //).with(headers: custom_headers)
    ).to have_been_made.at_least_once
  end

  def stub_ribose_ping_api_request(method = :get, client = nil)
    stub_api_response(method, "ping", filename: "ping", client: client)
  end
end
