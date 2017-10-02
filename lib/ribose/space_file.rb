require "ribose/file_uploader"

module Ribose
  class SpaceFile < Ribose::Base
    include Ribose::Actions::All

    # List Files for Space
    #
    # This interface retrieves the files for any specific space, and
    # the usages is pretty simple all we need to do, provide the space
    # id and it will return the files as `Sawyer::Resource`
    #
    # @param space_id [String] The spcific space Id
    # @param options [Hash] Query parameters as a Hash
    # @return [Array<Sawyer::Resource>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    def self.create(space_id, attributes)
      Ribose::FileUploader.new(space_id, attributes).upload
    end

    private

    attr_reader :space_id

    def resources_key
      "files"
    end

    def resources
      ["spaces", space_id, "file", "files"].join("/")
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end
  end
end
