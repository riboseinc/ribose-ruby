require "spec_helper"

RSpec.describe Ribose::Setting do
  describe ".all" do
    it "lists the user settings" do
      stub_ribose_setting_list_api
      settings = Ribose::Setting.all

      expect(settings.first.id).not_to be_nil
      expect(settings.first.type).to eq("Setting::Personal")
      expect(settings.first.time_zone_detected).to eq("Asia/Bangkok")
    end
  end

  describe ".fetch" do
    it "fetches the details for a setting" do
      setting_id = 123_456_789
      stub_ribose_setting_find_api(setting_id)
      setting = Ribose::Setting.fetch(setting_id)

      expect(setting.id).to eq(setting_id)
      expect(setting.type).to eq("Setting::Personal")
      expect(setting.time_zone_detected).to eq("Asia/Bangkok")
    end
  end

  describe ".update" do
    it "updates a setting with provided details" do
      new_theme_id = 6
      setting_id = 123_456_789

      stub_ribose_setting_update_api(setting_id, theme_id: new_theme_id)
      setting = Ribose::Setting.update(setting_id, theme_id: new_theme_id)

      expect(setting.id).to eq(setting_id)
      expect(setting.type).to eq("Setting::Personal")
      expect(setting.theme_id).to eq(new_theme_id.to_s)
    end
  end
end
