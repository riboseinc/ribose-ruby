require "spec_helper"

RSpec.describe Ribose::Feed do
  describe ".all" do
    it "retrieves the list of user feeds" do
      stub_ribose_feed_api
      feeds = Ribose::Feed.all

      expect(feeds.first.id).not_to be_nil
      expect(feeds.first.type).to eq("Feed::Basic")
      expect(feeds.first.instance_name).to eq("John Doe")
    end
  end
end
