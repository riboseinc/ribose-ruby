module Ribose
  module FakeRiboseApi
    def stub_ribose_space_list_api
      stub_api_response(:get, "spaces", filename: "spaces")
    end

    def stub_ribose_space_create_api(attributes)
      stub_api_response(
        :post, "spaces", data: { space: attributes }, filename: "space_created"
      )
    end

    def stub_ribose_space_fetch_api(space_id)
      stub_api_response(:get, "spaces/#{space_id}", filename: "space")
    end

    def stub_ribose_feed_api
      stub_api_response(:get, "feeds", filename: "feeds")
    end

    def stub_ribose_space_member_list(space_id)
      stub_api_response(:get, "spaces/#{space_id}/members", filename: "members")
    end

    def stub_ribose_setting_list_api
      stub_api_response(:get, "settings", filename: "settings")
    end

    def stub_ribose_setting_find_api(id)
      stub_api_response(:get, "settings/#{id}", filename: "setting")
    end

    def stub_ribose_stream_list_api
      stub_api_response(:get, "stream", filename: "stream")
    end

    def stub_ribose_widget_list_api
      stub_api_response(:get, "widgets", filename: "widgets")
    end

    def stub_ribose_calendar_list_api
      stub_api_response(:get, "calendar/calendar", filename: "calendar")
    end

    def stub_ribose_app_data_api
      stub_api_response(:get, "app_data", filename: "app_data")
    end

    def stub_ribose_space_file_list(space_id)
      file_endppoint = ["spaces", space_id, "file", "files"].join("/")
      stub_api_response(:get, file_endppoint, filename: "space_file")
    end

    def stub_ribose_leaderboard_api
      stub_api_response(
        :get, "activity_point/leaderboard", filename: "leaderboard"
      )
    end

    def stub_ribose_app_relation_list_api
      stub_api_response(:get, "app_relations", filename: "app_relations")
    end

    def stub_ribose_app_relation_find_api(relation_id)
      stub_api_response(
        :get, "app_relations/#{relation_id}", filename: "app_relation"
      )
    end

    def stub_ribose_connection_list_api
      stub_api_response(:get, "people/connections?s=", filename: "connections")
    end

    def stub_ribose_suggestion_list_api
      stub_api_response(
        :get, "people_finding", filename: "connection_suggestion"
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
      filename = [filename, "json"].join(".")
      file_path = File.join(Ribose.root, "spec", "fixtures", filename)

      File.read(File.expand_path(file_path, __FILE__))
    end

    def stub_api_response(method, endpoint, filename:, status: 200, data: nil)
      stub_request(method, ribose_endpoint(endpoint)).
        with(ribose_headers(data: data)).
        to_return(response_with(filename: filename, status: status))
    end
  end
end
