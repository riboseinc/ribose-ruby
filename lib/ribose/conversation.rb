module Ribose
  class Conversation < Ribose::Base
    include Ribose::Actions::All

    def create
      create_conversation[:conversation]
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

    private

    attr_reader :space_id

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end

    def resources
      ["spaces", space_id, "conversation", "conversations"].join("/")
    end

    def create_conversation
      Ribose::Request.post(
        resources, conversation: attributes.merge(space_id: space_id)
      )
    end
  end
end
