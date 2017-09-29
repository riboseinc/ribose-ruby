module Ribose
  class SpaceInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    def update
      update_invitation[resource_key]
    end

    def mass_create
      create_invitations[:invitations]
    end

    def self.mass_create(space_id, attributes)
      new(attributes.merge(space_id: space_id)).mass_create
    end

    def self.update(invitation_id, attributes)
      new(attributes.merge(invitation_id: invitation_id)).update
    end

    def self.accept(invitation_id)
      new(invitation_id: invitation_id, state: 1).update
    end

    def self.resend(invitation_id)
      Ribose::Request.post(
        "/invitations/to_new_member/#{invitation_id}/resend", {}
      )
    end

    def self.reject(invitation_id)
      new(invitation_id: invitation_id, state: 2).update
    end

    def self.cancel(invitation_id)
      Ribose::Request.delete(["invitations/to_space", invitation_id].join("/"))
    end

    private

    attr_reader :invitation_id

    def resource
      "invitation"
    end

    def resource_key
      "to_space"
    end

    def resources_key
      [resource_key, "s"].join
    end

    def resources
      "invitations/to_space"
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def validate(space_id:, invitee_id:, **attributes)
      attributes.merge(space_id: space_id, invitee_id: invitee_id)
    end

    def create_invitations
      Ribose::Request.post(mass_create_path, invitation: attributes)
    end

    def update_invitation
      Ribose::Request.put(
        [resources, invitation_id].join("/"), invitation: attributes
      )
    end

    def mass_create_path
      "/spaces/#{attributes[:space_id]}/invitations/to_space/mass_create"
    end
  end
end
