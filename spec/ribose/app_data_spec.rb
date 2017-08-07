require "spec_helper"

RSpec.describe Ribose::AppData do
  describe ".all" do
    it "retrieves the user's app data" do
      stub_ribose_app_data_api
      app_data = Ribose::AppData.all

      expect(app_data.user.login).to eq("john.doe")
      expect(app_data.user.from_ribose?).to be_falsey
      expect(app_data.misc.jabber.status).to eq("available")
      expect(app_data.misc.capps.first.app_name).to eq("app/dashboard")
    end
  end

  def stub_ribose_app_data_api
    stub_api_response(:get, "app_data", filename: "app_data", status: 200)
  end
end
