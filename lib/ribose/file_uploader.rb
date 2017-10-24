require "faraday"

module Ribose
  class FileUploader
    # Initialize the file uploader
    #
    # @param space_id [String] The Space UUID
    # @param file [File] The complete path for file
    # @param attributes [Hash] Attributes as a Hash
    def initialize(space_id, file:, **attributes)
      @space_id = space_id
      @file = File.new(file)
      @attributes = attributes
    end

    # Create a file upload
    #
    # @return [Sawyer::Resource] File upload response.
    def create
      upload_meta = prepare_to_upload
      response = upload_to_aws_s3(upload_meta)
      notify_ribose_file_upload_endpoint(response, upload_meta.fields.key)
    end

    # Create a new upload
    #
    # @param space_id [String] The Space UUID
    # @param file [File] The complete path for file
    # @param attributes [Hash] Attributes as a Hash
    # @return [Sawyer::Resource] File upload response.
    def self.upload(space_id, file:, **attributes)
      new(space_id, attributes.merge(file: file)).create
    end

    private

    attr_reader :file, :space_id, :attributes

    def prepare_to_upload
      file_upload_path = [space_file_path, "prepare"].join("/")
      Ribose::Request.get(file_upload_path, query: file_attributes)
    end

    def upload_to_aws_s3(meta)
      aws_connection(meta.url).post do |request|
        request.body = meta.fields.attrs.merge(file: faraday_file_io)
      end
    end

    def notify_ribose_file_upload_endpoint(response, key)
      if response.status.to_i == 200
        Ribose::Request.post(space_file_path, file_attributes.merge(key: key))
      end
    end

    def faraday_file_io
      Faraday::UploadIO.new(file.path, file_attributes[:filetype])
    end

    def space_file_path
      ["spaces", space_id, "file", "files"].join("/")
    end

    def file_content_type
      @file_content_type ||= content_type_form_file
    end

    def content_type_form_file
      require "mime/types"
      MIME::Types.type_for(file.path).first.content_type
    end

    def file_attributes
      @file_attributes ||= {
        filesize: file.size,
        filetype: file_content_type,
        filename: File.basename(file),
        file_info: {
          tag_list: attributes[:tag_list] || "",
          description: attributes[:description] || "",
        },
      }
    end

    def aws_connection(upload_url)
      Faraday.new(upload_url) do |builder|
        builder.request :multipart
        builder.request :url_encoded
        Ribose.configuration.add_default_middleware(builder)
      end
    end
  end
end
