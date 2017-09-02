module Ribose
  class Conversation < Ribose::Base
    include Ribose::Actions::All

    # Listing Space Conversations
    #
    # @param space_id [String] The Space UUID
    # @param options [Hash] Query parameters as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    private

    attr_reader :space_id

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end

    def resources
      ["spaces", space_id, "conversation", "conversations"].join("/")
    end
  end
end
