require "spec_helper"

RSpec.describe Ribose::Setting do
  describe ".all" do
    it "lists all user's setttings" do
      stub_ribose_setting_list_api
      settings = Ribose::Setting.all

      expect(settings.first.id).not_to be_nil
      expect(settings.first.type).to eq("Setting::Personal")
      expect(settings.first.time_zone_detected).to eq("Asia/Bangkok")
    end
  end
end
