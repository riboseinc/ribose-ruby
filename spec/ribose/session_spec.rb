require "spec_helper"

RSpec.describe Ribose::Session do
  describe ".create" do
    it "creates a new user session" do
      username = "super.user"
      password = "supper.secreet.password"

      stub_post_signin_request
      session = Ribose::Session.create(username: username, password: password)

      expect(session.uid).to eq(session_headers["uid"])
      expect(session.client).to eq(session_headers["client"])
      expect(session["access-token"]).to eq(session_headers["access-token"])
    end
  end

  def session_headers
    @session_headers ||= {
      "uid" => "user@example.com",
      "expiry" => Time.now,
      "client" => "sample-user-client",
      "access-token" => "super.secret.access.token",
    }
  end

  def stub_post_signin_request
    stub_request(:post, login_url).and_return(
      body:  ribose_fixture("empty"), headers: session_headers,
    )
  end

  def login_url
    [api_host, "api/v2/auth/sign_in"].join("/")
  end

  def api_host
    "https://#{Ribose.configuration.api_host}"
  end
end
