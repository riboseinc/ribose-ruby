module Ribose
  class SpaceInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    private

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

    def validate(space_id:, invitee_id:, **attributes)
      attributes.merge(space_id: space_id, invitee_id: invitee_id)
    end
  end
end
