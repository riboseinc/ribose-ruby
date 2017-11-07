require "spec_helper"

RSpec.describe "TestDeleteAction" do
  describe ".delete" do
    it "removes a specific resource" do
      resource_id = 123_456_789
      stub_ribose_calendar_delete_api(resource_id)

      expect { Ribose::TestDeleteAction.delete(resource_id) }.not_to raise_error
    end
  end

  module Ribose
    class TestDeleteAction < Ribose::Base
      include Ribose::Actions::Delete

      private

      def resources_path
        "calendar/calendar"
      end
    end
  end
end
