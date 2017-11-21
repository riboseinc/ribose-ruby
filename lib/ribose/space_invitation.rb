module Ribose
  class SpaceInvitation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Create
    include Ribose::Actions::Update
    include Ribose::Actions::Delete

    def mass_create
      create_invitations[:invitations]
    end

    def self.mass_create(space_id, attributes = {})
      new(attributes.merge(space_id: space_id)).mass_create
    end

    def self.update(invitation_id, attributes = {})
      new(attributes.merge(resource_id: invitation_id)).update
    end

    def self.accept(invitation_id, attributes = {})
      new(attributes.merge(resource_id: invitation_id, state: 1)).update
    end

    def self.resend(invitation_id, attributes = {})
      Ribose::Request.post(
        "/invitations/to_new_member/#{invitation_id}/resend", attributes
      )
    end

    def self.reject(invitation_id, attributes = {})
      new(attributes.merge(resource_id: invitation_id, state: 2)).update
    end

    def self.cancel(invitation_id, attributes = {})
      new(resource_id: invitation_id, **attributes).delete
    end

    private

    def resource
      "to_space"
    end

    def resource_key
      "invitation"
    end

    def resources_path
      "invitations/to_space"
    end

    def extract_local_attributes
      @invitation_id = attributes.delete(:invitation_id)
    end

    def validate(space_id:, invitee_id:, **attributes)
      attributes.merge(space_id: space_id, invitee_id: invitee_id)
    end

    def create_invitations
      Ribose::Request.post(
        mass_create_path, custom_option.merge(invitation: attributes)
      )
    end

    def mass_create_path
      "/spaces/#{attributes[:space_id]}/invitations/to_space/mass_create"
    end
  end
end
