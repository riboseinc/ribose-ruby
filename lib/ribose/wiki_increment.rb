module Ribose
  class WikiIncrement < Ribose::Base
    include Ribose::Actions::Create

    # Create wiki increments
    #
    # @param space_id [String] The space UUID
    # @param wiki_id [String] The wiki page UUID
    # @param optinons [Hash] Query parametars as Hash
    # @return [Sawyer::Resources] New wiki increment
    #
    def self.create(space_id:, wiki_id:, **attributes)
      new(space_id: space_id, wiki_id: wiki_id, **attributes).create
    end

    private

    attr_reader :space_id, :wiki_id

    def resource
      "increment"
    end

    def extract_local_attributes
      @wiki_id = attributes.delete(:wiki_id)
      @space_id = attributes.delete(:space_id)
    end

    def resources_path
      ["spaces", space_id, "wiki/wiki_pages", wiki_id, "increments"].join("/")
    end
  end
end
