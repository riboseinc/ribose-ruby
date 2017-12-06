require "spec_helper"

RSpec.describe Ribose::MemberRole do
  describe ".fetch" do
    it "retrieves the role for a member in a space" do
      space_id = 123_456_789
      member_id = 456_789_012

      stub_ribose_member_role_fetch_api(space_id, member_id)
      member_role = Ribose::MemberRole.fetch(space_id, member_id)

      expect(member_role.roles.first.name).to eq("Member")
      expect(member_role.roles.last.name).to eq("Administrator")
    end
  end

  describe ".assign" do
    it "assigns a role to a member in a space" do
      role_id = 789_123_456
      space_id = 123_456_789
      member_id = 456_789_012

      stub_ribose_member_role_assign(space_id, member_id, role_id)

      expect do
        Ribose::MemberRole.assign(space_id, member_id, role_id)
      end.not_to raise_error
    end
  end
end
