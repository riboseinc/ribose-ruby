require "spec_helper"

RSpec.describe Ribose::Config do
  after { restore_to_default_config }

  describe ".configure" do
    it "allows us to set our configuration" do
      api_host = "https://www.example.com"
      api_key = "SUPER_SECRET_API_KEY"

      Ribose.configure do |config|
        config.api_key = api_key
        config.api_host = api_host
        config.debug_mode = false
        config.response_type = :object
      end

      expect(Ribose.configuration.api_key).to eq(api_key)
      expect(Ribose.configuration.api_host).to eq(api_host)
    end
  end

  describe ".configuration" do
    it "returns the default configuration" do
      configuration = Ribose.configuration

      expect(configuration.api_key).to be_nil
      expect(configuration.debug_mode).to be_falsey
      expect(configuration.response_type).to eq(:object)
      expect(configuration.api_host).to eq("https://www.ribose.com")
    end
  end

  def restore_to_default_config
    Ribose.configuration.api_key = nil
    Ribose.configuration.api_host = "https://www.ribose.com"
  end
end
