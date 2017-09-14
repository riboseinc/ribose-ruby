require "ribose/actions"

module Ribose
  class Space < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create

    def self.create(name:, **attributes)
      new(attributes.merge(name: name)).create
    end

    def self.remove(space_uuid, options = {})
      Ribose::Request.post("spaces/#{space_uuid}/freeze", options)
    end

    private

    attr_reader :space

    def resource
      "space"
    end

    def resources
      "spaces"
    end

    def extract_local_attributes
      @space = attributes.delete(:space)
    end
  end
end
