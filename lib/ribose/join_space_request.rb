module Ribose
  class JoinSpaceRequest < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create

    private

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
  end
end
