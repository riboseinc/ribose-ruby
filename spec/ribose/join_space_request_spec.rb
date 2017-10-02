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

  describe ".update" do
    it "updates the details for a join request" do
      invitation_id = 123_456_789
      attributes = { state: 1, role_id: 101 }

      stub_ribose_join_space_request_update(invitation_id, attributes)
      invitation = Ribose::JoinSpaceRequest.update(invitation_id, attributes)

      expect(invitation.id).not_to be_nil
      expect(invitation.state).not_to be_nil
      expect(invitation.type).to eq("Invitation::JoinSpaceRequest")
    end
  end

  describe ".accept" do
    it "accepts a join request to a space" do
      invitation_id = 123_456_789

      stub_ribose_join_space_request_update(invitation_id, state: 1)
      invitation = Ribose::JoinSpaceRequest.accept(invitation_id)

      expect(invitation.state).to eq(1)
      expect(invitation.id).not_to be_nil
      expect(invitation.type).to eq("Invitation::JoinSpaceRequest")
    end
  end

  describe ".reject" do
    it "rejects a join request to a space" do
      invitation_id = 123_456_789

      stub_ribose_join_space_request_update(invitation_id, state: 2)
      invitation = Ribose::JoinSpaceRequest.reject(invitation_id)

      expect(invitation.id).not_to be_nil
      expect(invitation.state).not_to be_nil
      expect(invitation.type).to eq("Invitation::JoinSpaceRequest")
    end
  end
end
