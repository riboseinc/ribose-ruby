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

    # Create a new file upload
    #
    # @param space_id [String] The Space UUID
    # @param file [String] The complete path for the file
    # @param attributes [Hash] The file attributes as Hash
    # @return [Sawyer::Resource] The file upload response.
    #
    def self.create(space_id, file:, **attributes)
      upload = FileUploader.upload(space_id, attributes.merge(file: file))
      upload[:attachment]
    end

    private

    attr_reader :space_id

    def resource
      "file"
    end

    def resources_path
      ["spaces", space_id, "file", "files"].join("/")
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end
  end
end
