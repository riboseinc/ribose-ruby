require "spec_helper"

RSpec.describe Ribose::Stream do
  describe ".all" do
    it "retreives the list of notifications stream" do
      stub_ribose_stream_list_api
      stream = Ribose::Stream.all

      expect(stream.notifications.count).to eq(3)
      expect(stream.notifications.first.id).not_to be_nil
      expect(stream.notifications.first.data.first.info.action).to eq("create")
    end
  end

  def stub_ribose_stream_list_api
    stub_api_response(:get, "stream", filename: "stream", status: 200)
  end
end
