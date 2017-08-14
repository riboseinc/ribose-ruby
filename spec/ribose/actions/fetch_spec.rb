require "spec_helper"
require "ribose/actions/fetch"

RSpec.describe "TestFetchAction" do
  describe ".fetch" do
    it "fetches a specific resource" do
      resource_id = 123_456_789

      stub_ribose_space_fetch_api(resource_id)
      resource = Ribose::TestFetchAction.fetch(resource_id)

      expect(resource.id).not_to be_nil
      expect(resource.name).to eq("Work")
    end
  end

  def stub_ribose_space_fetch_api(resource_id)
    stub_api_response(:get, "spaces/#{resource_id}", filename: "space")
  end

  module Ribose
    class TestFetchAction < Ribose::Base
      include Ribose::Actions::Fetch

      private

      def resources
        "spaces"
      end
    end
  end
end
