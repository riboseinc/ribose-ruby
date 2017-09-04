module Ribose
  class Message < Ribose::Base
    include Ribose::Actions::All

    # Listing Conversation Messages
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] The Conversation UUID
    # @param options [Hash] The Query parameters as a Hash
    # @return [Array<Sawyer::Resource>]
    #
    def self.all(space_id:, conversation_id:, **options)
      new(space_id: space_id, conversation_id: conversation_id, **options).all
    end

    private

    attr_reader :space_id, :conversation_id

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
      @conversation_id = attributes.delete(:conversation_id)
    end

    def resources
      [conversations, conversation_id, "messages"].join("/")
    end

    def conversations
      ["spaces", space_id, "conversation/conversations"].join("/")
    end
  end
end
