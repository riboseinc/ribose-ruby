require "spec_helper"

RSpec.describe Ribose::Conversation do
  describe ".all" do
    it "retrieves the conversations for a space" do
      space_id = 123_456_789

      stub_ribose_space_conversation_list(space_id)
      conversations = Ribose::Conversation.all(space_id)

      expect(conversations.first.id).not_to be_nil
      expect(conversations.first.number_of_messages).to eq(0)
      expect(conversations.first.name).to eq("Sample conversation")
    end
  end
end
