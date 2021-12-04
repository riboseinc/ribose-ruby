require "spec_helper"

RSpec.describe Ribose::Client do
  describe "#new" do
    context "no attribtues provided" do
      it "initialize with default configuration" do
        client = Ribose::Client.new

        expect(client.api_token).to eq(Ribose.configuration.api_token)
        expect(client.api_email).to eq(Ribose.configuration.api_email)
      end
    end

    context "custom attribtues provided" do
      it "initialize with the supplied attribtues" do
        email = "john@ex.com"
        token = "SECRET_API_TOKEN"
        client = Ribose::Client.new(api_token: token, api_email: email)

        expect(client.api_token).to eq(token)
        expect(client.api_email).to eq(email)
      end
    end
  end

  describe ".from_login" do
    it "authenticate the user and build a client" do
      email = "user.email@gmail.com"
      password = "supser.secrect.password"

      allow(Ribose::Session).to receive(:create).and_return(session)
      client = Ribose::Client.from_login(email: email, password: password)

      expect(client.api_email).to eq(email)
      expect(client.uid).to eq(session.uid)
      expect(client.client_id).to eq(session.client)
    end
  end

  def session
    @session ||= Ribose::SessionData.new(
      uid: "hello",
      expiry: Time.now + 3600,
      client: "RIBOSE_RUBY_CLIENT",
    )
  end
end
