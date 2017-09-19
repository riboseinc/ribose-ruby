require "spec_helper"

RSpec.describe Ribose::SpaceInvitation do
  describe ".all" do
    it "retrieves the list of space invitations" do
      stub_ribose_space_invitation_lis_api
      invitations = Ribose::SpaceInvitation.all

      expect(invitations.count).to eq(1)
      expect(invitations.first.type).to eq("Invitation::ToSpace")
      expect(invitations.first.space.name).to eq("The CLI Space")
    end
  end
end
