require "spec_helper"

RSpec.describe Ribose::Space do
  describe ".all" do
    it "retrieves the list of user spaces" do
      stub_ribose_space_list_api
      spaces = Ribose::Space.all

      expect(spaces.first.id).to eq("123456789")
      expect(spaces.first.name).to eq("Work")
      expect(spaces.first.visibility).to eq("invisible")
    end
  end

  def stub_ribose_space_list_api
    stub_api_response(:get, "spaces", filename: "spaces", status: 200)
  end
end
