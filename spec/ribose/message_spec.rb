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

      stub_ribose_message_create(space_id, message: message_attrs)
      message = Ribose::Message.create(message_attrs.merge(space_id: space_id))

      expect(message.id).not_to be_nil
      expect(message.user.name).to eq("John Doe")
      expect(message.contents).to eq("Welcome to Ribose")
    end
  end

  def message_attrs
    { contents: "Welcome to Ribose", conversation_id: "456789" }
  end

  def stub_ribose_message_create(sid, attributes)
    cid = attributes[:message][:conversation_id]
    message_path = "spaces/#{sid}/conversation/conversations/#{cid}/messages"

    stub_api_response(
      :post, message_path, data: attributes, filename: "message_created"
    )
  end
end
