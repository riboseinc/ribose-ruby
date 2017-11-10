module Ribose
  class Wiki < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Update

    # List wiki pages
    #
    # @param space_id [String] The space UUID
    # @param options [Hash] Query parameters
    # @retrun [Array <Sawyer::Resoruce>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    # Fetch a wiki page
    #
    # @param space_id [String] The space UUID
    # @param wiki_id [String] The Wiki UUID
    # @return [Sawyer::Resoruce]
    #
    def self.fetch(space_id, wiki_id, options = {})
      new(space_id: space_id, resource_id: wiki_id, **options).fetch
    end

    # Create a wiki page
    #
    # @param space_id [String] The space UUID
    # @param attributes [Hash] Wiki page attributes
    # @return [Sawyer::Resoruce] Newly created wiki
    #
    def self.create(space_id, attributes)
      new(space_id: space_id, **attributes).create
    end

    # Update a wiki page
    #
    # @param space_id [String] The space UUID
    # @param wiki_id [String] The wiki-page UUID
    # @param attributes [Hash] Wiki page attributes
    #
    # @return [Sawyer::Resoruce] Updated wiki page
    #
    def self.update(space_id, wiki_id, attributes)
      new(space_id: space_id, resource_id: wiki_id, **attributes).update
    end

    private

    attr_reader :space_id

    def resource
      "wiki_page"
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end

    def validate(name:, **attributes)
      attributes.merge(name: name)
    end

    def resources_path
      ["spaces", space_id, "wiki", resources].join("/")
    end
  end
end
