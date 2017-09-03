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

  describe ".create" do
    it "creates a new conversation into a space" do
      space_id = 123_456_789

      stub_ribose_space_conversation_create(space_id, conversation_attrs)
      conversation = Ribose::Conversation.create(space_id, conversation_attrs)

      expect(conversation.id).not_to be_nil
      expect(conversation.name).to eq("Sample Conversation")
      expect(conversation.tag_list).to eq(["sample", "conversation"])
    end
  end

  def conversation_attrs
    {
      name: "Sample Conversation",
      tag_list: "sample, conversation",
      space_id: 123456789,
    }
  end
end
