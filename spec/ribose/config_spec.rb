require "spec_helper"

RSpec.describe Ribose::Config do
  before { restore_to_default_config }
  after { restore_to_default_config }

  describe ".configure" do
    it "allows us to set our configuration" do
      api_host = "www.example.com"
      api_token = "SUPER_SECRET_API_TOKEN"
      user_email = "john.doe@example.com"
      faraday_options = {some: :options}

      Ribose.configure do |config|
        config.api_host = api_host
        config.api_token = api_token
        config.user_email = user_email
        config.faraday_options = faraday_options
      end

      expect(Ribose.configuration.api_host).to eq(api_host)
      expect(Ribose.configuration.debug_mode?).to be_falsey
      expect(Ribose.configuration.api_token).to eq(api_token)
      expect(Ribose.configuration.user_email).to eq(user_email)
      expect(Ribose.configuration.faraday_options).to eq(faraday_options)
      expect(Ribose.configuration.web_url).to eq ["https", api_host].join("://")
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
    Ribose.configuration.faraday_options = {}
  end
end
