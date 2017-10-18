require "spec_helper"

RSpec.describe Ribose::Calendar do
  describe ".all" do
    it "retrieves the list of user calenders" do
      stub_ribose_calendar_list_api
      calendar = Ribose::Calendar.all

      expect(calendar.cal_info.first.id).not_to be_nil
      expect(calendar.cal_info.first.owner_type).to eq("User")
      expect(calendar.cal_info.first.can_manage).to be_truthy
    end
  end

  describe ".fetch" do
    it "retrieves the details for a calendar" do
      calendar_id = 123_456_789

      stub_ribose_calendar_fetch_api(calendar_id)
      calendar = Ribose::Calendar.fetch(calendar_id)

      expect(calendar.id).not_to be_nil
      expect(calendar.owner_type).to eq("User")
      expect(calendar.name).to eq("Sample 101")
    end
  end

  describe ".create" do
    it "creates a new calendar with provided details" do
      calendar_attributes = { owner_type: "User", name: "Sample" }

      stub_ribose_calendar_create_api(calendar_attributes)
      calendar = Ribose::Calendar.create(calendar_attributes)

      expect(calendar.id).not_to be_nil
      expect(calendar.owner_type).to eq("User")
    end
  end

  describe ".delete" do
    it "removes a valid user calendar" do
      calendar_id = 123_456_789
      stub_ribose_calendar_delete_api(calendar_id)

      expect do
        Ribose::Calendar.delete(calendar_id)
      end.not_to raise_error
    end
  end
end
