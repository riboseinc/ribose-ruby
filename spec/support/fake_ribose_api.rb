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

    def stub_ribose_space_update_api(uuid, attributes)
      stub_api_response(
        :put, "spaces/#{uuid}", data: { space: attributes }, filename: "space"
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

    def stub_ribose_space_delete_api(space_id, options = {})
      stub_api_response(
        :delete, "spaces/#{space_id}", data: options, filename: "empty"
      )
    end

    def stub_ribose_feed_api
      stub_api_response(:get, "feeds", filename: "feeds")
    end

    def stub_ribose_space_member_list(space_id)
      stub_api_response(:get, "spaces/#{space_id}/members", filename: "members")
    end

    def stub_ribose_space_member_delete_api(space_id, member_id)
      stub_api_response(
        :delete, "spaces/#{space_id}/members/#{member_id}", filename: "empty"
      )
    end

    def stub_ribose_member_role_fetch_api(space_id, user_id)
      stub_api_response(
        :get,
        "people/users/#{user_id}/roles/get_roles?in_space=#{space_id}",
        filename: "member_role",
      )
    end

    def stub_ribose_member_role_assign(space_id, user_id, role_id)
      stub_api_response(
        :put,
        "people/users/#{user_id}/roles/change_assignment?in_space=#{space_id}",
        data: { checked_role: role_id },
        filename: "empty",
      )
    end

    def stub_ribose_setting_list_api
      stub_api_response(:get, "settings", filename: "settings")
    end

    def stub_ribose_setting_find_api(id)
      stub_api_response(:get, "settings/#{id}", filename: "setting")
    end

    def stub_ribose_setting_update_api(uuid, attributes)
      stub_api_response(
        :put,
        "settings/#{uuid}",
        data: { setting: attributes },
        filename: "setting",
      )
    end

    def stub_ribose_stream_list_api
      stub_api_response(:get, "stream", filename: "stream")
    end

    def stub_ribose_widget_list_api
      stub_api_response(:get, "widgets", filename: "widgets")
    end

    def stub_ribose_calendar_list_api
      stub_api_response(:get, "calendar/calendar", filename: "calendars")
    end

    def stub_ribose_calendar_fetch_api(calender_id)
      stub_api_response(
        :get,
        "calendar/calendar/#{calender_id}",
        filename: "calendar",
      )
    end

    def stub_ribose_calendar_events_api(calendar_ids, length: 7)
      data = OpenStruct.new(
        length: length,
        cals: Ribose.encode_ids(calendar_ids),
        start: Date.today.to_time.to_i / (60 * 60 * 24),
      )

      params = "cal_ids=#{data.cals}&length=#{data.length}&start=#{data.start}"

      stub_api_response(
        :get, "calendar/calendar/?#{params}", filename: "calendar_events"
      )
    end

    def stub_ribose_calendar_create_api(attributes)
      stub_api_response(
        :post,
        "calendar/calendar",
        data: { calendar: attributes },
        filename: "calendar",
      )
    end

    def stub_ribose_calendar_delete_api(calender_id)
      stub_api_response(
        :delete, "calendar/calendar/#{calender_id}", filename: "empty"
      )
    end

    def stub_ribose_event_fetch_api(calender_id, event_id)
      stub_api_response(
        :get,
        "calendar/calendar/#{calender_id}/event/#{event_id}",
        filename: "calendar_event",
      )
    end

    def stub_ribose_event_create_api(calender_id, event_attributes)
      stub_api_response(
        :post,
        "calendar/calendar/#{calender_id}/event",
        data: { event: event_attributes },
        filename: "event_created",
      )
    end

    def stub_ribose_event_update_api(calender_id, event_id, attributes)
      stub_api_response(
        :put,
        "calendar/calendar/#{calender_id}/event/#{event_id}",
        data: { event: attributes },
        filename: "event_updated",
      )
    end

    def stub_ribose_event_delete_api(calender_id, event_id)
      stub_api_response(
        :delete,
        "calendar/calendar/#{calender_id}/event/#{event_id}",
        filename: "empty",
      )
    end

    def stub_ribose_app_user_create_api(attributes)
      stub_api_response(
        :post,
        "signup_requests",
        data: { user: attributes },
        filename: "empty",
      )
    end

    def stub_ribose_app_user_activate_api(attributes)
      stub_api_response(
        :post,
        "api/v2/auth",
        data: { user: attributes },
        filename: "user_activated",
      )
    end

    def stub_ribose_app_data_api
      stub_api_response(:get, "app_data", filename: "app_data")
    end

    def stub_ribose_space_file_list(space_id)
      file_endppoint = ["spaces", space_id, "file", "files"].join("/")
      stub_api_response(:get, file_endppoint, filename: "space_files")
    end

    def stub_ribose_space_file_fetch_api(space_id, file_id)
      file_endppoint = ["spaces", space_id, "file", "files", file_id].join("/")
      stub_api_response(:get, file_endppoint, filename: "space_file")
    end

    def stub_ribose_space_file_fetch_icon_api(space_id, file_id)
      path = ["spaces", space_id, "file", "files", file_id, "icon"].join("/")
      stub_api_response(:get, path, filename: "space_file_icon")
    end

    def stub_ribose_space_file_update_api(space_id, file_id, attributes)
      stub_api_response(
        :put,
        ["spaces", space_id, "file", "files", file_id].join("/"),
        data: { file_info: attributes },
        filename: "space_file",
      )
    end

    def stub_ribose_space_file_delete_api(space_id, file_id)
      file_endppoint = ["spaces", space_id, "file", "files", file_id].join("/")
      stub_api_response(:delete, file_endppoint, filename: "empty")
    end

    def stub_ribose_file_version_fetch_api(sid, fid, vid)
      stub_api_response(
        :get,
        ["spaces", sid, "file/files", fid, "versions", vid].join("/"),
        filename: "file_version",
      )
    end

    def stub_ribose_file_version_download_api(sid, fid, vid)
      version = ["spaces", sid, "file/files", fid, "versions", vid].join("/")
      stub_request(:get, ribose_endpoint(version)).to_return(
        headers: { location: "https://ribose-data.aws.com", status: 302 },
      )
    end

    def stub_aws_file_version_download_api(content)
      stub_request(:get, "https://ribose-data.aws.com").to_return(body: content)
    end

    def stub_ribose_space_conversation_list(space_id)
      stub_api_response(
        :get, conversations_path(space_id), filename: "conversations"
      )
    end

    def stub_ribose_space_conversation_fetch_api(space_id, conv_id)
      stub_api_response(
        :get,
        [conversations_path(space_id), conv_id].join("/"),
        filename: "conversation",
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

    def stub_ribose_space_conversation_update_api(sid, cid, attributes)
      attributes.delete(:space_id)

      stub_api_response(
        :put,
        [conversations_path(sid), cid].join("/"),
        data: { conversation: attributes },
        filename: "conversation",
      )
    end

    def stub_ribose_space_conversation_mafav_api(sid, cid)
      stub_api_response(
        :put,
        [conversations_path(sid), cid, "mark_as_favorite"].join("/"),
        filename: "conversation",
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

    def stub_ribose_connection_delete_api(id)
      stub_api_response(
        :delete, ["people", "connections", id].join("/"), filename: "empty"
      )
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

    def stub_ribose_join_space_request_fetch_api(invitation_id)
      stub_api_response(
        :get,
        ["invitations", "join_space_request", invitation_id].join("/"),
        filename: "join_space_request",
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

    def stub_ribose_fetch_profile_api
      stub_api_response(:get, "people/profile/", filename: "profile")
    end

    def stub_ribose_update_profile_api(attributes)
      stub_api_response(
        :put, "people/profile/", data: { user: attributes }, filename: "profile"
      )
    end

    def stub_ribose_set_login_name_api(user_id, name)
      stub_api_response(
        :put,
        "people/users/#{user_id}",
        data: { user: { login: name } },
        filename: "profile",
      )
    end

    def stub_ribose_wiki_list_api(space_id)
      stub_api_response(
        :get, "spaces/#{space_id}/wiki/wiki_pages", filename: "wikis"
      )
    end

    def stub_ribose_wiki_fetch_api(sid, wiki_id)
      stub_api_response(
        :get, "spaces/#{sid}/wiki/wiki_pages/#{wiki_id}", filename: "wiki"
      )
    end

    def stub_ribose_wiki_create_api(space_id, attributes)
      stub_api_response(
        :post,
        "spaces/#{space_id}/wiki/wiki_pages",
        data: { wiki_page: attributes },
        filename: "wiki",
      )
    end

    def stub_ribose_wiki_update_api(space_id, wiki_id, attributes)
      stub_api_response(
        :put,
        "spaces/#{space_id}/wiki/wiki_pages/#{wiki_id}",
        data: { wiki_page: attributes },
        filename: "wiki",
      )
    end

    def stub_ribose_wiki_delete_api(sid, wiki_id)
      stub_api_response(
        :delete, "spaces/#{sid}/wiki/wiki_pages/#{wiki_id}", filename: "empty"
      )
    end

    def stub_ribose_space_categories_api
      stub_api_response(
        :get, "space_categories", filename: "space_categories"
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

    def ribose_headers(data: nil, client: nil)
      client ||= Ribose::Client.new

      Hash.new.tap do |request|
        request[:headers] = ribose_auth_headers(client)

        unless data.nil?
          request[:body] = data.to_json
        end
      end
    end

    def ribose_auth_headers(client)
      Hash.new.tap do |headers|
        headers["Accept"] = "application/json"

        if Ribose.configuration.api_token
          headers["X-Indigo-Token"] = client.api_token
          headers["X-Indigo-Email"] = client.user_email
        end
      end
    end

    def response_with(filename:, status:, content_type: "application/json")
      {
        status: status,
        body: ribose_fixture(filename),
        headers: { content_type: content_type },
      }
    end

    def ribose_fixture(filename, ext = "json")
      filename = [filename, ext].join(".")
      file_path = File.join(Ribose.root, "spec", "fixtures", filename)

      File.read(File.expand_path(file_path, __FILE__))
    end

    def stub_api_response(method, endpoint, filename:, status: 200, data: nil,
                          client: nil, content_type: "application/json")
      stub_request(method, ribose_endpoint(endpoint)).
        with(ribose_headers(data: data, client: client)).
        to_return(
          response_with(
            filename: filename, status: status, content_type: content_type,
          ),
        )
    end
  end
end
