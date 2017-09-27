module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    def update
      update_invitation[resource_key]
    end

    def create
      create_invitations[:invitations]
    end

    def self.create(body:, emails:)
      new(body: body, emails: emails).create
    end

    def self.accept(invitation_id)
      new(invitation_id: invitation_id, state: 1).update
    end

    def self.reject(invitation_id)
      new(invitation_id: invitation_id, state: 2).update
    end

    def self.cancel(invitation_id)
      Ribose::Request.delete("invitations/to_connection/#{invitation_id}")
    end

    private

    attr_reader :invitation_id

    def resource
      "invitation"
    end

    def resource_key
      "to_connection"
    end

    def resources_key
      [resource_key, "s"].join
    end

    def resources
      "invitations/to_connection"
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def create_invitations
      Ribose::Request.post(
        [resources, "mass_create"].join("/"),
        invitation: { body: attributes[:body], emails: attributes[:emails] },
      )
    end

    def update_invitation
      Ribose::Request.put(
        [resources, invitation_id].join("/"),
        invitation: { state: attributes[:state] },
      )
    end
  end
end
