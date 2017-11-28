require "ribose/actions"

module Ribose
  class Space < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Update

    def self.create(name:, **attributes)
      new(attributes.merge(name: name)).create
    end

    def self.remove(space_uuid, options = {})
      Ribose::Request.post("spaces/#{space_uuid}/freeze", options)
    end

    def self.delete(space_uuid, confirmation:, **options)
      remove(space_uuid, options.merge(password_confirmation: confirmation))
    end

    private

    attr_reader :space

    def resource
      "space"
    end

    def extract_local_attributes
      @space = attributes.delete(:space)
    end
  end
end
