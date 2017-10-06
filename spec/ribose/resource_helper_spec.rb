require "spec_helper"
require "ribose/resource_helper"

RSpec.describe "TestResourceHelper" do
  describe "helpers" do
    context "without any customization" do
      it "builds and returns the default values" do
        resource = Ribose::TestResourceHelper.new

        expect(resource.resource).to eq("resource")
        expect(resource.resources).to eq("resources")

        expect(resource.resources_path).to eq("resources")
        expect(resource.resource_path).to eq("resources/123456789")
      end

      context "with customization" do
        it "returns the custom values when available" do
          custom_resource = Ribose::CustomResourceHelper.new

          expect(custom_resource.resources).to eq("resources")
          expect(custom_resource.resources_path).to eq("resource/nested")
          expect(custom_resource.resource_path).to eq("custom/nested/123456789")
        end
      end
    end
  end

  module Ribose
    class TestResourceHelper
      include Ribose::ResourceHelper

      def resource
        "resource"
      end

      def resource_id
        123_456_789
      end
    end

    class CustomResourceHelper
      include Ribose::ResourceHelper

      def resource
        "resource"
      end

      def resources_path
        "resource/nested"
      end

      def resource_path
        "custom/nested/123456789"
      end
    end
  end
end
