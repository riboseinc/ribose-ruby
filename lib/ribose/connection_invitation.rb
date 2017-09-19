module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All

    private

    def resources_key
      "to_connections"
    end

    def resources
      "invitations/to_connection"
    end
  end
end
