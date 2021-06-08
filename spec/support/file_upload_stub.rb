require "faraday"

module Ribose
  module FileUploadStub
    def stub_ribose_space_file_upload_api(space_id, attributes, file_id = nil)
      stub_ribose_aws_s3_file_upload_api
      stub_ribose_file_prepare_api(space_id, attributes, file_id)
      stub_ribose_file_upload_notify_api(space_id, attributes, file_id)
    end

    def stub_ribose_file_prepare_api(space_id, attributes, file_id = nil)
      stub_api_response(
        :get,
        ribose_prepare_endpoint(space_id, attributes, file_id),
        filename: "file_upload_prepared",
      )
    end

    def stub_ribose_aws_s3_file_upload_api
      stub_request(:post, ribose_endpoint("uploads")).
        with(headers: { "Content-Type" => /multipart\/form-data/ }).
        to_return(response_with(filename: "empty", status: 200))
    end

    def stub_ribose_file_upload_notify_api(space_id, attributes, file_id = nil)
      stub_api_response(
        :post,
        ribose_file_endpoint(space_id, file_id),
        data: build_notify_request_body(attributes, file_id),
        filename: "file_uploaded",
        content_type: "text/html",
      )
    end

    private

    def ribose_file_endpoint(space_id, file_id = nil)
      end_path = file_id ? "#{file_id}/versions" : nil
      ["spaces", space_id, "file", "files", end_path].compact.join("/")
    end

    def ribose_prepare_endpoint(sid, attrs, file_id = nil)
      [ribose_file_endpoint(sid, file_id), "prepare?#{prepare_params(attrs)}"].
        join("/")
    end

    def prepare_params(attributes)
      Faraday::Utils.build_nested_query(
        extract_file_details(attributes).merge(
          file_info: extract_file_info(attributes),
        ),
      )
    end

    def build_notify_request_body(attributes, file_id = nil)
      file_info_key = file_id ? "file_info_version" : "file_info"

      extract_file_details(attributes).merge(
        file_info_key.to_sym => extract_file_info(attributes),
        key: "uploads/123456789/${filename}",
      )
    end

    def content_type_form_file(file)
      require "mime/types"
      mime = MIME::Types.type_for(file).first
      mime ? mime.content_type : "application/octet-stream"
    end

    def extract_file_details(attributes)
      {
        filesize: File.new(attributes[:file]).size,
        filetype: content_type_form_file(attributes[:file]),
        filename: File.basename(attributes[:file]),
      }
    end

    def extract_file_info(attributes)
      { tag_list: attributes[:tag_list], description: attributes[:description] }
    end
  end
end
