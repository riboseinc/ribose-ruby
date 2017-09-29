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
end
