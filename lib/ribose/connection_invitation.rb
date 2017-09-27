module Ribose
  class ConnectionInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    def accept
      accept_inviation[resource_key]
    end

    def self.accept(invitation_id)
      new(invitation_id: invitation_id).accept
    end

    def self.cancel(invitation_id)
      Ribose::Request.delete("invitations/to_connection/#{invitation_id}")
    end

    private

    attr_reader :invitation_id

    def resource_key
      "to_connection"
    end

    def resources_key
      [resource_key, "s"].join
    end

    def resources
      "invitations/to_connection"
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def accept_inviation
      Ribose::Request.put(
        [resources, invitation_id].join("/"), invitation: { state: 1 }
      )
    end
  end
end
