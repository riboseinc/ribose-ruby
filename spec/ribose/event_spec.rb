require "spec_helper"

RSpec.describe Ribose::Event do
  describe ".all" do
    it "retrieves the list of events" do
      calendar_id = 123
      stub_ribose_calendar_events_api(calendar_id)

      calendar_events = Ribose::Event.all(calendar_id).events

      expect(calendar_events.first.id).not_to be_nil
      expect(calendar_events.first.calendar_id).to eq(123)
      expect(calendar_events.first.name).to eq("Sample event")
    end
  end

  describe ".fetch" do
    it "retrives the details for an event" do
      event_id = 456_789
      calendar_id = 123_456_789

      stub_ribose_event_fetch_api(calendar_id, event_id)
      event = Ribose::Event.fetch(calendar_id, event_id)

      expect(event.id).to eq(event_id)
      expect(event.name).to eq("Sample event")
      expect(event.calendar_id).to eq(calendar_id)
    end
  end

  describe ".delete" do
    it "removes a calendar event" do
      event_id = 456_789
      calendar_id = 123_456_789
      stub_ribose_event_delete_api(calendar_id, event_id)

      expect do
        Ribose::Event.delete(calendar_id, event_id)
      end.not_to raise_error
    end
  end
end
