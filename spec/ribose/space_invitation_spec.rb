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

  describe ".create" do
    it "creates an invitation to a specific space" do
      stub_ribose_space_invitation_create_api(invitation_attributes)
      invitation = Ribose::SpaceInvitation.create(invitation_attributes)

      expect(invitation.id).not_to be_nil
      expect(invitation.inviter.name).to eq("John Doe")
      expect(invitation.type).to eq("Invitation::ToSpace")
      expect(invitation.space.name).to eq("Trip to Mars!")
    end
  end

  describe ".mass_create" do
    it "creates multiple inviations to a space" do
      space_id = 123_456_789

      attributes = {
        role_ids: [123_456_789],
        emails: ["jennie.doe@example.com"],
        body: "Hi, I would like to join you to this space",
      }

      stub_ribose_space_invitation_mass_create(space_id, attributes)
      invitation = Ribose::SpaceInvitation.mass_create(space_id, attributes)

      expect(
        invitation.success.emails.first[0].to_s,
      ).to eq(attributes[:emails].first.to_s)
    end
  end

  describe ".update" do
    it "updates a space invitation" do
      invitation_id = 123_456_789
      attributes = { role_id: 123 }

      stub_ribose_space_invitation_update_api(invitation_id, attributes)
      invitation = Ribose::SpaceInvitation.update(invitation_id, attributes)

      expect(invitation.id).not_to be_nil
      expect(invitation.role_id).not_to be_nil
      expect(invitation.type).to eq("Invitation::ToSpace")
    end
  end

  describe ".accept" do
    it "accepts a space invitation" do
      invitation_id = 123_456_789
      stub_ribose_space_invitation_update_api(invitation_id, state: 1)

      invitation = Ribose::SpaceInvitation.accept(invitation_id)

      expect(invitation.state).to eq(1)
      expect(invitation.id).not_to be_nil
      expect(invitation.type).to eq("Invitation::ToSpace")
    end
  end

  describe ".resend" do
    it "resends a space invitation to non-member email" do
      invitation_id = 123_456_789

      stub_ribose_space_invitation_resend_api(invitation_id)
      invitation = Ribose::SpaceInvitation.resend(invitation_id)

      expect(invitation.to_space).not_to be_nil
      expect(invitation.to_space.id).not_to be_nil
    end
  end

  describe ".reject" do
    it "rejects a space invitation" do
      invitation_id = 123_456_789
      stub_ribose_space_invitation_update_api(invitation_id, state: 2)

      invitation = Ribose::SpaceInvitation.reject(invitation_id)

      expect(invitation.id).not_to be_nil
      expect(invitation.state).not_to be_nil
      expect(invitation.type).to eq("Invitation::ToSpace")
    end
  end

  describe ".cancel" do
    it "cancels a space invitation" do
      invitation_id = 123_456_789
      stub_ribose_space_invitation_cancel_api(invitation_id)

      expect do
        Ribose::SpaceInvitation.cancel(invitation_id)
      end.not_to raise_error
    end
  end

  def invitation_attributes
    @invitation ||= {
      state: "0",
      body: "Please join!",
      space_id: "123_456_789",
      invitee_id: "456_789_012",
    }
  end
end
