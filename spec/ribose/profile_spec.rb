require "spec_helper"

RSpec.describe Ribose::Profile do
  describe ".fetch" do
    it "retrieves the current user profile" do
      stub_ribose_fetch_profile_api
      profile = Ribose::Profile.fetch

      expect(profile.id).not_to be_nil
      expect(profile.first_name).to eq("John")
      expect(profile.name).to eq("John Doe")
    end
  end
end
