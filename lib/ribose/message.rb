module Ribose
  class Message
    include Ribose::Actions::All
    include Ribose::Actions::Create

    # Message initilaiztion
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] The Conversation UUID
    # @param attributes [Hash] The Message related attributes
    # @return [Ribose::Message] The `Ribose::Message` Instance
    #
    def initialize(space_id, conversation_id, attributes = {})
      @space_id = space_id
      @attributes = attributes
      @conversation_id = conversation_id
      @message_id = attributes.delete(:message_id)
    end

    def update
      update_message[:message]
    end

    def remove
      Ribose::Request.delete([resources, message_id].join("/"))
    end

    # Listing Conversation Messages
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] The Conversation UUID
    # @param options [Hash] The Query parameters as a Hash
    # @return [Array<Sawyer::Resource>]
    #
    def self.all(space_id:, conversation_id:, **options)
      new(space_id, conversation_id, **options).all
    end

    # Create A New Message
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] The Conversation UUID
    # @param attributes [Hash] The message attributes
    # @return [Sawyer::Resource]
    #
    def self.create(space_id:, conversation_id:, **attributes)
      new(space_id, conversation_id, attributes).create
    end

    # Update A Messsage
    #
    # @param space_id [String] The Space UUID
    # @param message_id [String] The Message UUID
    # @param conversation_id [String] The Conversation UUID
    # @param attributes [Hash] The message attributes
    # @return [Sawyer::Resource]
    #
    def self.update(space_id:, message_id:, conversation_id:, **attrs)
      new(space_id, conversation_id, attrs.merge(message_id: message_id)).update
    end

    # Remove A Message
    #
    # @param space_id [String] The Space UUID
    # @param message_id [String] The Message UUID
    # @param conversation_id [String] The Conversation UUID
    # @return [Sawyer::Resource]
    #
    def self.remove(space_id:, message_id:, conversation_id:)
      new(space_id, conversation_id, message_id: message_id).remove
    end

    private

    attr_reader :space_id, :message_id, :conversation_id, :attributes

    def resource
      "message"
    end

    def resources
      [conversations, conversation_id, "messages"].join("/")
    end

    def validate(attributes)
      attributes.merge(conversation_id: conversation_id)
    end

    def conversations
      ["spaces", space_id, "conversation/conversations"].join("/")
    end

    def update_message
      Ribose::Request.put(
        [resources, message_id].join("/"), message: attributes
      )
    end
  end
end
