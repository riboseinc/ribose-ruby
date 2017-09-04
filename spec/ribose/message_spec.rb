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
end
