require "spec_helper"

RSpec.describe "Ribose Errors" do
  context "when response is 200" do
    it "does not raise any error" do
      stub_ping_request_with(200)
      expect { create_ping_request }.not_to raise_error
    end
  end

  context "when response is 201" do
    it "does not raise any error" do
      stub_ping_request_with(201)
      expect { create_ping_request }.not_to raise_error
    end
  end

  context "when response is 400" do
    it "retuns the bad request error" do
      stub_ping_request_with(400)
      expect { create_ping_request }.to raise_error(Ribose::BadRequest)
    end
  end

  context "when response is 401" do
    it "returns the unauthorized error" do
      stub_ping_request_with(401)
      expect { create_ping_request }.to raise_error(Ribose::Unauthorized)
    end
  end

  context "when response is 403" do
    it "returns the forbidden error" do
      stub_ping_request_with(403)
      expect { create_ping_request }.to raise_error(Ribose::Forbidden)
    end
  end

  context "when response is 404" do
    it "returns the not_found error" do
      stub_ping_request_with(404)
      expect { create_ping_request }.to raise_error(Ribose::NotFound)
    end
  end

  context "when response is 422" do
    it "returns unprocessable entity error" do
      stub_ping_request_with(422)
      expect { create_ping_request }.to raise_error(Ribose::UnprocessableEntity)
    end
  end

  context "when the response is 5xx" do
    it "returns server error" do
      stub_ping_request_with(501)
      expect { create_ping_request }.to raise_error(Ribose::ServerError)
    end
  end

  def create_ping_request
    Ribose::Request.get("/ping")
  end

  def stub_ping_request_with(status = 200, method = :get)
    stub_api_response(method, "ping", filename: "ping", status: status)
  end
end
