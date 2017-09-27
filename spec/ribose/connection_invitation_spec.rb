require "spec_helper"

RSpec.describe Ribose::ConnectionInvitation do
  describe ".all" do
    it "retrieves all of the connection invitations" do
      stub_ribose_connection_invitation_lis_api
      invitations = Ribose::ConnectionInvitation.all

      expect(invitations.count).to eq(1)
      expect(invitations.first.inviter.name).to eq("Jennie Doe")
      expect(invitations.first.email).to eq("john.doe@example.com")
    end
  end

  describe ".fetch" do
    it "retrieves the details of an invitation" do
      invitation_id = 123_456_789
      stub_ribose_connection_invitation_fetch_api(invitation_id)
      invitation = Ribose::ConnectionInvitation.fetch(invitation_id)

      expect(invitation.id).not_to be_nil
      expect(invitation.inviter.name).to eq("Jennie Doe")
      expect(invitation.email).to eq("jennie.doe@example.com")
      expect(invitation.type).to eq("Invitation::ToConnection")
    end
  end

  describe ".accept" do
    it "accepts a connection invitation" do
      invitation_id = 123_456_789

      stub_ribose_connection_invitation_update_api(invitation_id, 1)
      invitation = Ribose::ConnectionInvitation.accept(invitation_id)

      expect(invitation.state).to eq(1)
      expect(invitation.id).not_to be_nil
      expect(invitation.inviter.name).to eq("Jennie Doe")
    end
  end

  describe ".reject" do
    it "rejects a connection invitation" do
      invitation_id = 123_456_789

      stub_ribose_connection_invitation_update_api(invitation_id, 2)
      invitation = Ribose::ConnectionInvitation.reject(invitation_id)

      expect(invitation.id).not_to be_nil
      expect(invitation.state).not_to be_nil
      expect(invitation.inviter.name).to eq("Jennie Doe")
    end
  end

  describe ".cancel" do
    it "cancels a pending connection inviation" do
      invitation_id = 123_456_789
      stub_ribose_connection_invitation_cancel_api(invitation_id)

      expect do
        Ribose::ConnectionInvitation.cancel(invitation_id)
      end.not_to raise_error
    end
  end
end
