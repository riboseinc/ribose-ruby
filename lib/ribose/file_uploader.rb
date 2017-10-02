require "faraday"

module Ribose
  class FileUploader
    def upload
      connection.post do |request|
        request.headers[:accept] = "*/*"
        request.headers["cache-control"] = "no-cache"
        request.headers["X-Indigo-Token"] = Ribose.configuration.api_token
        request.headers["X-Indigo-Email"] = Ribose.configuration.user_email

        request.body = file_payload
      end
    end

    def self.upload
      new.upload
    end

    private

    def connection
      Faraday.new(file_upload_url) do |builder|
        builder.request :multipart
        # builder.request :url_encoded

        builder.response :logger, nil, bodies: true

        builder.adapter Faraday.default_adapter
      end
    end

    def file_upload_url
      "https://www.ribose.com/spaces/#{space_id}/file/files/upload?file_info[tag_list]="
    end

    def space_id
      "52e47e18-9a9d-4663-94c5-abcb18fa783a"
    end

    def file_payload
      # { file_info: { attachment: file_io } }
      {data: [ file_io ]}
    end

    def file_io
      Faraday::UploadIO.new("/Users/abunashir/Desktop/sample.jpg", "image/jpeg")
    end
  end
end
