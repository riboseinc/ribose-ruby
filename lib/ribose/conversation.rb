module Ribose
  class Conversation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    def remove
      Ribose::Request.delete(resource_path)
    end

    # Listing Space Conversations
    #
    # @param space_id [String] The Space UUID
    # @param options [Hash] Query parameters as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    # Create A New Conversation
    #
    # @param space_id [String] The Space UUID
    # @param attributes [Hash] The conversation attributes
    # @return [Sawyer::Resource]
    #
    def self.create(space_id, attributes)
      new(attributes.merge(space_id: space_id)).create
    end

    def self.remove(space_id:, conversation_id:)
      new(space_id: space_id, conversation_id: conversation_id).remove
    end

    private

    attr_reader :space_id, :conversation_id
    alias_method :resource_id, :conversation_id

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
      @conversation_id = attributes.delete(:conversation_id)
    end

    def resource
      "conversation"
    end

    def resources_path
      ["spaces", space_id, "conversation", "conversations"].join("/")
    end

    def validate(attributes)
      attributes.merge(space_id: space_id)
    end
  end
end
