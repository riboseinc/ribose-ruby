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

  describe ".fetch" do
    it "fetches a specific user space" do
      space_id = 123_456_789

      stub_ribose_space_fetch_api(space_id)
      space = Ribose::Space.fetch(space_id)

      expect(space.id).not_to be_nil
      expect(space.name).to eq("Work")
      expect(space.role_name).to eq("Administrator")
    end
  end

  def stub_ribose_space_list_api
    stub_api_response(:get, "spaces", filename: "spaces", status: 200)
  end

  def stub_ribose_space_fetch_api(space_id)
    stub_api_response(:get, "spaces/#{space_id}", filename: "space")
  end
end
