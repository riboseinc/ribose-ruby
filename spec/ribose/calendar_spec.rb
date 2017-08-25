require "spec_helper"

RSpec.describe Ribose::Calendar do
  describe ".all" do
    it "retrieves the details for a calendar" do
      stub_ribose_calendar_list_api
      calendar = Ribose::Calendar.all

      expect(calendar.cal_info.first.id).not_to be_nil
      expect(calendar.cal_info.first.owner_type).to eq("User")
      expect(calendar.cal_info.first.can_manage).to be_truthy
    end
  end
end
