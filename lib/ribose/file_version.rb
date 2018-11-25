require "ribose/version_uploader"

module Ribose
  class FileVersion < Ribose::Base
    include Ribose::Actions::Fetch

    def download
      download_file || raise(Ribose::BadRequest)
    end

    # Fetch file version
    #
    # @params :space_id [UUID] The space Id
    # @params :file_id [UUID] The space file Id
    # @params :version_id [UUID] The file version Id
    # @returns [Sawyer::Resource] The file version
    #
    def self.fetch(space_id:, file_id:, version_id:, **options)
      new(
        file_id: file_id,
        space_id: space_id,
        resource_id: version_id,
        **options,
      ).fetch
    end

    # Download file version
    #
    # @param space_id [UUID] The space Id
    # @param file_id [Integer] The file Id
    # @param version_id [Hash] The file version Id
    # @param options [Hash] Options as key and value pair
    #
    def self.download(space_id, file_id, version_id:, **options)
      new(
        file_id: file_id,
        space_id: space_id,
        resource_id: version_id,
        **options,
      ).download
    end

    # Create a new file version
    #
    # @params space_id [UUID] The space UUID
    # @params file_id [Integer] The space file ID
    # @params file [File] The new version for file
    # @params attributes [Hash] Other file attributes
    # @return [Sawyer::Resource] Newly updated version
    #
    def self.create(space_id, file_id, file:, **attributes)
      upload = VersionUploader.upload(
        space_id, file_id, attributes.merge(file: file)
      )

      upload[:attachment]
    end

    private

    attr_reader :output, :file_id, :space_id

    def resource
      nil
    end

    def extract_local_attributes
      @output = attributes.delete(:output)
      @file_id = attributes.delete(:file_id)
      @space_id = attributes.delete(:space_id)
    end

    def resource_path
      [files_path, file_id, "versions", resource_id].join("/")
    end

    def files_path
      ["spaces", space_id, "file", "files"].join("/")
    end

    def download_file
      data = Ribose::Request.get(
        resource_path, parse: false, headers: { accept: "text/html" }
      )

      if data.headers["status"].match?(/^30[12]/)
        fetch_and_write_to_file(data)
      end
    end

    def fetch_and_write_to_file(data)
      File.open(output || "download", "w") do |file|
        file << data.agent.call(:get, data.headers["location"]).data
      end
    end
  end
end
