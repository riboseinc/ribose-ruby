module Ribose
  class JoinSpaceRequest < Ribose::Base
    include Ribose::Actions::All

    private

    def resources_key
      "join_space_requests"
    end

    def resources
      "invitations/join_space_request"
    end
  end
end
