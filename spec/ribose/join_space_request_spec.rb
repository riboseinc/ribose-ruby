require "spec_helper"

RSpec.describe Ribose::JoinSpaceRequest do
  describe ".all" do
    it "retrieves the list of all join space requests" do
      stub_ribose_join_space_request_list_api
      invitations = Ribose::JoinSpaceRequest.all

      expect(invitations.first.id).not_to be_nil
      expect(invitations.first.type).to eq("Invitation::ToSpace")
    end
  end

  describe ".create" do
    it "creates a new join space request" do
      attributes = {
        state: 0,
        type: "Invitation::JoinSpaceRequest",
        body: "Hi, I would like to join to your space",
        space_id: 123_456_789,
      }

      stub_ribose_join_space_request_create_api(attributes)
      invitation = Ribose::JoinSpaceRequest.create(attributes)

      expect(invitation.id).not_to be_nil
      expect(invitation.inviter.name).to eq("John Doe")
    end
  end
end
