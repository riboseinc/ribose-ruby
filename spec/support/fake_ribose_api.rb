require File.join(Ribose.root, "spec/support/file_upload_stub")

module Ribose
  module FakeRiboseApi
    include Ribose::FileUploadStub

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

    def stub_ribose_space_remove_api(space_uuid, options = {})
      stub_api_response(
        :post, "spaces/#{space_uuid}/freeze", data: options, filename: "empty"
      )
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

    def stub_ribose_space_conversation_list(space_id)
      stub_api_response(
        :get, conversations_path(space_id), filename: "conversations"
      )
    end

    def stub_ribose_space_conversation_create(space_id, attributes)
      stub_api_response(
        :post,
        conversations_path(space_id),
        filename: "conversation_created",
        data: { conversation: attributes },
      )
    end

    def stub_ribose_space_conversation_remove(space_id, conversation_id)
      path = [conversations_path(space_id), conversation_id].join("/")
      stub_api_response(:delete, path, filename: "empty", status: 200)
    end

    def stub_ribose_message_list(space_id, conversation_id)
      stub_api_response(
        :get, messages_path(space_id, conversation_id), filename: "messages"
      )
    end

    def stub_ribose_message_create(space_id, attributes)
      path = messages_path(space_id, attributes[:message][:conversation_id])
      stub_api_response(:post, path, data: attributes, filename: "message")
    end

    def stub_ribose_message_update(space_id, message_id, attributes)
      conversation_id = attributes[:message].delete(:conversation_id)
      path = [messages_path(space_id, conversation_id), message_id].join("/")

      stub_api_response(:put, path, data: attributes, filename: "message")
    end

    def stub_ribose_message_remove(space_id, message_id, conversation_id)
      path = [messages_path(space_id, conversation_id), message_id].join("/")
      stub_api_response(:delete, path, filename: "empty", status: 200)
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

    def stub_ribose_connection_invitation_lis_api
      stub_api_response(
        :get, "invitations/to_connection", filename: "connection_invitations"
      )
    end

    def stub_ribose_connection_invitation_fetch_api(invitation_id)
      stub_api_response(
        :get,
        "invitations/to_connection/#{invitation_id}",
        filename: "connection_invitation",
      )
    end

    def stub_ribose_connection_invitation_create_api(emails, body)
      stub_api_response(
        :post,
        "invitations/to_connection/mass_create",
        filename: "connection_invitations_created",
        data: { invitation: { body: body, emails: emails } },
      )
    end

    def stub_ribose_connection_invitation_update_api(invitation_id, state)
      stub_api_response(
        :put,
        "invitations/to_connection/#{invitation_id}",
        data: { invitation: { state: state } },
        filename: "connection_invitation_accepted",
      )
    end

    def stub_ribose_connection_invitation_cancel_api(invitation_id)
      stub_api_response(
        :delete, "invitations/to_connection/#{invitation_id}", filename: "empty"
      )
    end

    def stub_ribose_space_invitation_lis_api
      stub_api_response(
        :get, "invitations/to_space", filename: "space_invitations"
      )
    end

    def stub_ribose_space_invitation_create_api(attributes)
      stub_api_response(
        :post,
        "invitations/to_space",
        data: { invitation: attributes },
        filename: "space_invitation",
      )
    end

    def stub_ribose_space_invitation_mass_create(space_id, attributes)
      stub_api_response(
        :post,
        "spaces/#{space_id}/invitations/to_space/mass_create",
        data: { invitation: attributes.merge(space_id: space_id) },
        filename: "space_mass_invitations",
      )
    end

    def stub_ribose_space_invitation_resend_api(invitation_id)
      stub_api_response(
        :post,
        "invitations/to_new_member/#{invitation_id}/resend",
        filename: "space_invitation_updated",
      )
    end

    def stub_ribose_space_invitation_update_api(invitation_id, attributes)
      stub_api_response(
        :put,
        "invitations/to_space/#{invitation_id}",
        data: { invitation: attributes },
        filename: "space_invitation_updated",
      )
    end

    def stub_ribose_space_invitation_cancel_api(invitation_id)
      stub_api_response(
        :delete, "invitations/to_space/#{invitation_id}", filename: "empty"
      )
    end

    def stub_ribose_join_space_request_list_api
      stub_api_response(
        :get, "invitations/join_space_request", filename: "join_space_requests"
      )
    end

    def stub_ribose_join_space_request_create_api(attributes)
      stub_api_response(
        :post,
        "invitations/join_space_request",
        data: { invitation: attributes },
        filename: "join_space_request_created",
      )
    end

    def stub_ribose_join_space_request_update(invitation_id, attributes)
      stub_api_response(
        :put,
        "invitations/join_space_request/#{invitation_id}",
        data: { invitation: attributes },
        filename: "join_space_request_updated",
      )
    end

    private

    def ribose_endpoint(endpoint)
      ["https://www.ribose.com", endpoint].join("/")
    end

    def conversations_path(space_id)
      ["spaces", space_id, "conversation", "conversations"].join("/")
    end

    def messages_path(space_id, conversation_id)
      [conversations_path(space_id), conversation_id, "messages"].join("/")
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
