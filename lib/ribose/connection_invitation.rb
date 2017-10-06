module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Update

    def create
      create_invitations[:invitations]
    end

    def self.create(body:, emails:)
      new(body: body, emails: emails).create
    end

    def self.accept(invitation_id)
      new(resource_id: invitation_id, state: 1).update
    end

    def self.reject(invitation_id)
      new(resource_id: invitation_id, state: 2).update
    end

    def self.cancel(invitation_id)
      Ribose::Request.delete("invitations/to_connection/#{invitation_id}")
    end

    private

    def resource
      "to_connection"
    end

    def resource_key
      "invitation"
    end

    def resources_path
      "invitations/to_connection"
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def create_invitations
      Ribose::Request.post(
        [resources_path, "mass_create"].join("/"),
        invitation: { body: attributes[:body], emails: attributes[:emails] },
      )
    end
  end
end
