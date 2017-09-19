module Ribose
  class SpaceInvitation < Ribose::Base
    include Ribose::Actions::All

    private

    def resources_key
      "to_spaces"
    end

    def resources
      "invitations/to_space"
    end
  end
end
