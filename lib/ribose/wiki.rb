module Ribose
  class Wiki < Ribose::Base
    include Ribose::Actions::All

    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    private

    attr_reader :space_id

    def resource
      "wiki_page"
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end

    def resources_path
      ["spaces", space_id, "wiki", "wiki_pages"].join("/")
    end
  end
end
