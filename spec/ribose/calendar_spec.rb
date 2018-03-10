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
    it "retrieves the events for calendars" do
      calendar_ids = [123, 456]

      stub_ribose_calendar_events_api(calendar_ids)
      events = Ribose::Calendar.fetch(calendar_ids).events

      expect(events.first.id).not_to be_nil
      expect(events.first.calendar_id).to eq(123)
      expect(events.first.name).to eq("Sample event")
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
