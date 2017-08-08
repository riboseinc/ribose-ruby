module Ribose
  module FakeRiboseApi
    def stub_ribose_setting_list_api
      stub_api_response(
        :get, "settings", filename: "settings", status: 200
      )
    end

    private

    def ribose_endpoint(endpoint)
      ["https://www.ribose.com", endpoint].join("/")
    end

    def ribose_headers(data: nil)
      Hash.new.tap do |request|
        request[:headers] = ribose_auth_headers

        unless data.nil?
          request[:body] = data.to_json
        end
      end
    end

    def ribose_auth_headers
      {
        "Accept" => "application/json",
        "X-Indigo-Token" => Ribose.configuration.api_token,
        "X-Indigo-Email" => Ribose.configuration.user_email,
      }
    end

    def response_with(filename:, status:)
      {
        status: status,
        body: ribose_fixture(filename),
        headers: { content_type: "application/json" },
      }
    end

    def ribose_fixture(filename)
      file_name = [filename, "json"].join(".")
      file_path = File.join("../../", "fixtures", file_name)

      File.read(File.expand_path(file_path, __FILE__))
    end

    def stub_api_response(method, endpoint, filename:, status: 200, data: nil)
      stub_request(method, ribose_endpoint(endpoint)).
        with(ribose_headers(data: data)).
        to_return(response_with(filename: filename, status: status))
    end
  end
end
