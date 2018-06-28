require "faraday"

module Ribose
  module FileUploadStub
    def stub_ribose_space_file_upload_api(space_id, attributes)
      stub_ribose_aws_s3_file_upload_api
      stub_ribose_file_prepare_api(space_id, attributes)
      stub_ribose_file_upload_notify_api(space_id, attributes)
    end

    def stub_ribose_file_prepare_api(space_id, attributes)
      stub_api_response(
        :get,
        ribose_prepare_endpoint(space_id, attributes),
        filename: "file_upload_prepared",
      )
    end

    def stub_ribose_aws_s3_file_upload_api
      stub_request(:post, ribose_endpoint("uploads")).
        with(headers: { "Content-Type"=> /multipart\/form-data/ }).
        to_return(response_with(filename: "empty", status: 200))
    end

    def stub_ribose_file_upload_notify_api(space_id, attributes)
      stub_api_response(
        :post,
        ribose_file_endpoint(space_id),
        data: build_notify_request_body(attributes),
        filename: "file_uploaded",
        content_type: "text/html",
      )
    end

    private

    def ribose_file_endpoint(space_id)
      ["spaces", space_id, "file", "files"].join("/")
    end

    def ribose_prepare_endpoint(sid, attrs)
      [ribose_file_endpoint(sid), "prepare?#{prepare_params(attrs)}"].join("/")
    end

    def prepare_params(attributes)
      Faraday::Utils.build_nested_query(
        extract_file_details(attributes).merge(
          file_info: extract_file_info(attributes),
        ),
      )
    end

    def build_notify_request_body(attributes)
      extract_file_details(attributes).merge(
        file_info: extract_file_info(attributes),
        key: "uploads/123456789/${filename}",
      )
    end

    def content_type_form_file(file)
      require "mime/types"
      MIME::Types.type_for(file).first.content_type
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
