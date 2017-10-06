require "spec_helper"
require "ribose/actions/update"

RSpec.describe "TestUpdateAction" do
  describe ".update" do
    it "updates a resource with provided details" do
      resource_id = 123_456_789
      attributes = { attribute_name: "attribute_value" }

      stub_ribose_resource_update_api_call(resource_id, attributes)
      resource = Ribose::TestUpdateAction.update(resource_id, attributes)

      expect(resource.id).not_to be_nil
    end
  end

  module Ribose
    class TestUpdateAction < Ribose::Base
      include Ribose::Actions::Update

      private

      def resource
        "space"
      end
    end
  end

  def stub_ribose_resource_update_api_call(resource_id, attributes)
    resource_path = ["spaces", resource_id].join("/")

    stub_api_response(
      :put, resource_path, data: { space: attributes }, filename: "space"
    )
  end
end
