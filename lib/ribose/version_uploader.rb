require "ribose/file_uploader"

module Ribose
  class VersionUploader < Ribose::FileUploader
    def initialize(space_id, file_id, file:, **attributes)
      @file_id = file_id
      super(space_id, file: file, **attributes)
    end

    def self.upload(space_id, file_id, file:, **attributes)
      new(space_id, file_id, **attributes.merge(file: file)).create
    end

    private

    attr_reader :file_id

    def notifiable_attributes(attributes, key)
      attributes[:file_info_version] = attributes.delete(:file_info)
      attributes.merge(key: key)
    end

    def space_file_path
      ["spaces", space_id, "file", "files", file_id, "versions"].join("/")
    end
  end
end
