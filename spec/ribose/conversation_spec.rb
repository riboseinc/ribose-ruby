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

  describe ".fetch" do
    it "retrieves a specific converstion details" do
      space_id = 123_456_789
      conversation_id = 456_789

      stub_ribose_space_conversation_fetch_api(space_id, conversation_id)
      conversation = Ribose::Conversation.fetch(space_id, conversation_id)

      expect(conversation.id).not_to be_nil
      expect(conversation.name).to eq("Trips to the Mars!")
      expect(conversation.contents).to eq("Did you already book the tickets?")
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

  describe ".update" do
    it "updates a conversation with provided details" do
      space_id = 123_456_789
      conversation_id = 456_789

      stub_ribose_space_conversation_update_api(
        space_id, conversation_id, conversation_attrs
      )

      conversation = Ribose::Conversation.update(
        space_id, conversation_id, conversation_attrs
      )

      expect(conversation.id).not_to be_nil
      expect(conversation.contents).to eq("Did you already book the tickets?")
    end
  end

  describe ".mark_as_favorite" do
    it "marks a conversation as favorite" do
      space_id = 123_456_789
      conversation_id = 456_789
      stub_ribose_space_conversation_mafav_api(space_id, conversation_id)

      conversation = Ribose::Conversation.mark_as_favorite(
        space_id, conversation_id
      )

      expect(conversation.is_favorite).to eq(true)
    end
  end

  describe ".destroy" do
    it "remvoes a conversation from a space" do
      space_id = 123456789
      conversation_id = 987_654_321

      stub_ribose_space_conversation_remove(space_id, conversation_id)

      expect do
        Ribose::Conversation.destroy(
          space_id: space_id, conversation_id: conversation_id,
        )
      end.not_to raise_error
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
