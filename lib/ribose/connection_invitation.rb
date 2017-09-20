module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    def self.cancel(invitation_id)
      Ribose::Request.delete("invitations/to_connection/#{invitation_id}")
    end

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
