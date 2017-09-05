module Ribose
  class Message < Ribose::Base
    include Ribose::Actions::All

    def create
      create_message[:message]
    end

    def update
      update_message[:message]
    end

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

    # Create A New Message
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] The Conversation UUID
    # @param attributes [Hash] The message attributes
    # @return [Sawyer::Resource]
    #
    def self.create(space_id:, conversation_id:, **attributes)
      message_attributes = attributes.merge(
        space_id: space_id, conversation_id: conversation_id,
      )

      new(message_attributes).create
    end

    # Update an existing messsage
    #
    # @param space_id [String] The Space UUID
    # @param message_id [String] The Message UUID
    # @param conversation_id [String] The Conversation UUID
    # @param attributes [Hash] The message attributes
    # @return [Sawyer::Resource]
    #
    def self.update(space_id:, message_id:, conversation_id:, **attributes)
      message_attributes = attributes.merge(
        space_id: space_id,
        message_id: message_id,
        conversation_id: conversation_id,
      )

      new(message_attributes).update
    end

    private

    attr_reader :space_id, :conversation_id, :message_id

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
      @message_id = attributes.delete(:message_id)
      @conversation_id = attributes.delete(:conversation_id)
    end

    def resources
      [conversations, conversation_id, "messages"].join("/")
    end

    def conversations
      ["spaces", space_id, "conversation/conversations"].join("/")
    end

    def create_message
      Ribose::Request.post(
        resources, message: attributes.merge(conversation_id: conversation_id)
      )
    end

    def update_message
      Ribose::Request.put(
        [resources, message_id].join("/"), message: attributes
      )
    end
  end
end
