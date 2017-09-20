module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    private

    def resource_key
      "to_connection"
    end

    def resources_key
      [resource_key, "s"].join
    end

    def resources
      "invitations/to_connection"
    end
  end
end
