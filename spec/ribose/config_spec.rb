require "spec_helper"

RSpec.describe Ribose::Config do
  after { restore_to_default_config }

  describe ".configure" do
    it "allows us to set our configuration" do
      api_host = "www.example.com"
      api_token = "SUPER_SECRET_API_TOKEN"
      user_email = "john.doe@example.com"

      Ribose.configure do |config|
        config.api_host = api_host
        config.api_token = api_token
        config.user_email = user_email
      end

      expect(Ribose.configuration.api_host).to eq(api_host)
      expect(Ribose.configuration.api_token).to eq(api_token)
      expect(Ribose.configuration.user_email).to eq(user_email)
    end
  end

  describe ".configuration" do
    it "returns the default configuration" do
      configuration = Ribose.configuration

      expect(configuration.api_token).to be_nil
      expect(configuration.api_host).to eq("www.ribose.com")
    end
  end

  def restore_to_default_config
    Ribose.configuration.api_token = nil
    Ribose.configuration.user_email = nil
    Ribose.configuration.api_host = "www.ribose.com"
  end
end
