module Ribose
  class JoinSpaceRequest < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    def update
      update_invitation[resource_key]
    end

    def self.accept(invitation_id)
      new(invitation_id: invitation_id, state: 1).update
    end

    def self.reject(invitation_id)
      new(invitation_id: invitation_id, state: 2).update
    end

    private

    attr_reader :invitation_id

    def resource
      "invitation"
    end

    def resource_key
      "join_space_request"
    end

    def resources_key
      "join_space_requests"
    end

    def resources
      "invitations/join_space_request"
    end

    def validate(space_id:, **attributes)
      attributes.merge(space_id: space_id)
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def update_invitation
      Ribose::Request.put(
        [resources, invitation_id].join("/"), invitation: attributes
      )
    end
  end
end
