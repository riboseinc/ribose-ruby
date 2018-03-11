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
end
