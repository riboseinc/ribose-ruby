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
end
