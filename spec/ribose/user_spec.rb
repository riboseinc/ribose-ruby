require "spec_helper"

RSpec.describe Ribose::User do
  before { restore_to_default_config }
  after { set_configuration_for_test_env }

  describe ".create" do
    it "creates a new signup request for user" do
      user_attributes = { email: "john.doe@example.com" }
      stub_ribose_app_user_create_api(user_attributes)

      expect do
        Ribose::User.create(user_attributes)
      end.not_to raise_error
    end
  end

  describe ".activate" do
    it "complete the user signup process" do
      stub_ribose_app_user_activate_api(user_attributes)
      user = Ribose::User.activate(**user_attributes)

      expect(user.id).not_to be_nil
      expect(user.name).to eq("John Doe")
      expect(user.connected).to be_truthy
    end
  end

  def user_attributes
    @user_attributes ||= {
      email: "john.doe@example.com",
      password: "SecurePassword",
      edata: "OTP_RECEIVED_VIA_EMAIL",
    }
  end

  def restore_to_default_config
    Ribose.configuration.api_token = nil
    Ribose.configuration.user_email = nil
  end

  def set_configuration_for_test_env
    Ribose.configure do |config|
      config.api_token = ENV["RIBOSE_API_TOKEN"] || "RIBOSE_API_TOKEN"
      config.user_email = ENV["RIBOSE_USER_EMAIL"] || "RIBOSE_USER_EMAIL"
    end
  end
end
