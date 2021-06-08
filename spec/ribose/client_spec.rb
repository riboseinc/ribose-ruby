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

  describe ".from_login" do
    it "authenticate the user and build a client" do
      email = "useremail@example..com"
      password = "supersecretpassword"

      allow(Ribose::Session).to receive(:create).and_return(session_hash)
      client = Ribose::Client.from_login(email: email, password: password)

      expect(client.user_email).to eq(email)
      expect(client.api_token).to eq(session_hash["authentication_token"])
    end
  end

  def session_hash
    {
      "authentication_token" => "SecretToken",
      "last_activity" => {
        "id" => 122072207,
        "session_id" => "SessionId",
        "browser" => "Ribose Ruby Client",
        "user_id" => "user-uuid-123-4567",
      },
    }
  end
end
