module Ribose
  class Conversation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Update
    include Ribose::Actions::Delete

    # Listing Space Conversations
    #
    # @param space_id [String] The Space UUID
    # @param options [Hash] Query parameters as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    # Fetch a conversation
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] Conversation UUID
    # @param options [Hash] Query parameters as a Hash
    # @return [Sawyer::Resource] The conversation
    #
    def self.fetch(space_id, conversation_id, options = {})
      new(space_id: space_id, conversation_id: conversation_id, **options).fetch
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

    # Update a conversation
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] Conversation UUID
    # @param attributes [Hash] Query parameters as a Hash
    # @return [Sawyer::Resource] The updated conversation
    #
    def self.update(space_id, conversation_id, attributes = {})
      new(
        space_id: space_id,
        conversation_id: conversation_id,
        **attributes,
      ).update
    end

    # Remove a conversation
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] Conversation UUID
    # @param options [Hash] Query parameters as a Hash
    #
    def self.destroy(space_id:, conversation_id:, **opts)
      new(space_id: space_id, conversation_id: conversation_id, **opts).delete
    end

    def mark_as_favorite
      response = Ribose::Request.put(
        "#{resource_path}/mark_as_favorite",
        resource_key.to_sym => { is_favorite: true },
      )

      response[resource]
    end

    # Mark a conversation a favorite
    #
    # @param space_id [String] The Space UUID
    # @param conversation_id [String] Conversation UUID
    #
    def self.mark_as_favorite(space_id, conversation_id)
      new(space_id: space_id, conversation_id: conversation_id).mark_as_favorite
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
