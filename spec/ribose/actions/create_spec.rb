require "spec_helper"
require "ribose/actions/create"

RSpec.describe "TestCreateAction" do
  describe ".create" do
    it "creates a new resource with provided details" do
      stub_ribose_space_create_api(space_attributes)
      space = Ribose::TestCreateAction.create(space_attributes)

      expect(space.id).not_to be_nil
      expect(space.name).to eq("Trip to the Mars")
      expect(space.visibility).to eq("invisible")
    end
  end

  def space_attributes
    {
      access: "private",
      space_category_id: 12,
      description: "The long awaited dream!",
      name: "Trip to the Mars",
    }
  end

  module Ribose
    class TestCreateAction < Ribose::Base
      include Ribose::Actions::Create

      private

      def resource
        "space"
      end

      def resources
        [resource, "s"].join
      end
    end
  end
end
