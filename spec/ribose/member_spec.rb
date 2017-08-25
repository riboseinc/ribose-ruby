require "spec_helper"

RSpec.describe Ribose::Member do
  describe ".all" do
    it "retrieves all members for a space" do
      space_id = 123_456_789
      stub_ribose_space_member_list(space_id)

      members = Ribose::Member.all(space_id)

      expect(members.count).to eq(1)
      expect(members.first.user.name).to eq("John Doe")
      expect(members.first.role_name_in_space).to eq("Administrator")
    end
  end
end
