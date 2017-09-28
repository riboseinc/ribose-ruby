module Ribose
  class SpaceInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    def update
      update_invitation[resource_key]
    end

    def self.accept(invitation_id)
      new(invitation_id: invitation_id, state: 1).update
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

    def update_invitation
      Ribose::Request.put(
        [resources, invitation_id].join("/"),
        invitation: { state: attributes[:state] },
      )
    end
  end
end
