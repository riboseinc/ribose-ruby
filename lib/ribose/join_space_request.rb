module Ribose
  class JoinSpaceRequest < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create
    include Ribose::Actions::Update

    def self.accept(invitation_id)
      new(resource_id: invitation_id, state: 1).update
    end

    def self.reject(invitation_id)
      new(resource_id: invitation_id, state: 2).update
    end

    def self.update(invitation_id, attributes)
      new(attributes.merge(resource_id: invitation_id)).update
    end

    private

    def resource
      "join_space_request"
    end

    def resource_key
      "invitation"
    end

    def resources_path
      "invitations/join_space_request"
    end

    def validate(space_id:, **attributes)
      attributes.merge(space_id: space_id)
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end
  end
end
