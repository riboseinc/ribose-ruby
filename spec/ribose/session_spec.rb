require "spec_helper"

RSpec.describe Ribose::Session do
  describe ".create" do
    it "creates a new user session" do
      username = "super.user"
      password = "supper.secreet.password"

      stub_session_creation_request_via_web
      session = Ribose::Session.create(username: username, password: password)

      expect(session["created_at"]).not_to be_nil
      expect(session["authentication_token"]).to eq("user-super-secret-token")
    end
  end

  def login_url
    ribose_url_for("api/v2/auth/sign_in")
  end

  def ribose_url_for(*endpoints)
    [Ribose.configuration.api_host, *endpoints].join("/")
  end

  def stub_session_creation_request_via_web
    stub_get_request_with_login_page
    stub_post_request_with_empty_body
    stub_general_inforomation_request
  end

  def stub_get_request_with_login_page
    stub_request(:get, login_url).and_return(
      body: ribose_fixture("login", "html"),
      headers: { content_type: "text/html" },
    )
  end

  def stub_general_inforomation_request
    stub_request(:get, ribose_url_for(["settings", "general", "info"])).
      and_return(body: ribose_fixture("general_information"), status: 200)
  end

  def stub_post_request_with_empty_body
    stub_request(:post, login_url).and_return(body: ribose_fixture("empty"))
  end
end
