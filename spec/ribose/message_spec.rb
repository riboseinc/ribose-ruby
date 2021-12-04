require "spec_helper"

RSpec.describe Ribose::Message do
  describe ".all" do
    it "retrieves all conversation messages" do
      space_id = 123_456
      conversation_id = 456_789
      stub_ribose_message_list(space_id, conversation_id)

      messages = Ribose::Message.all(
        space_id: space_id, conversation_id: conversation_id,
      )

      expect(messages.first.id).not_to be_nil
      expect(messages.first.user.name).to eq("John Doe")
      expect(messages.first.contents).to eq("Welcome to Ribose Space")
    end
  end

  describe ".create" do
    it "creates a new message into a conversation" do
      space_id = 123_456
      message_attributes = message_attrs.merge(space_id: space_id)

      stub_ribose_message_create(space_id, message: message_attrs)
      message = Ribose::Message.create(**message_attributes)

      expect(message.id).not_to be_nil
      expect(message.user.name).to eq("John Doe")
      expect(message.contents).to eq("Welcome to Ribose")
    end
  end

  describe ".update" do
    it "updates an existing conversation message" do
      space_id = 123_456
      message_id = 789_012_345

      stub_ribose_message_update(space_id, message_id, message: message_attrs)
      message = Ribose::Message.update(
        **message_attrs.merge(space_id: space_id, message_id: message_id),
      )

      expect(message.user.name).to eq("John Doe")
      expect(message.contents).to eq("Welcome to Ribose")
    end
  end

  describe ".remove" do
    it "remvoes a message from the conversation" do
      space_id = 123_456
      message_id = 789_012_345
      conversation_id = 9282737373

      stub_ribose_message_remove(space_id, message_id, conversation_id)

      expect do
        Ribose::Message.remove(
          space_id: space_id,
          message_id: message_id,
          conversation_id: conversation_id,
        )
      end.not_to raise_error
    end
  end

  def message_attrs
    { contents: "Welcome to Ribose", conversation_id: "456789" }
  end
end
