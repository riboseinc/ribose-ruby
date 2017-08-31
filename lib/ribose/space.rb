require "ribose/actions"

module Ribose
  class Space < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    def create
      create_space[:space]
    end

    def self.create(name:, **attributes)
      new(space: attributes.merge(name: name)).create
    end

    def self.remove(space_uuid, options = {})
      Ribose::Request.post("spaces/#{space_uuid}/freeze", options)
    end

    private

    attr_reader :space

    def resources
      "spaces"
    end

    def create_space
      Ribose::Request.post(resources, space: space)
    end

    def extract_local_attributes
      @space = attributes.delete(:space)
    end
  end
end
