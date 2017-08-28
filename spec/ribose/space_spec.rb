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

  describe ".create" do
    it "creates a new space with provided details" do
      stub_ribose_space_create_api(space_attributes)
      space = Ribose::Space.create(space_attributes)

      expect(space.id).not_to be_nil
      expect(space.visibility).to eq("invisible")
      expect(space.name).to eq("Trip to the Mars")
    end
  end

  def space_attributes
    {
      access: "private",
      space_category_id: 12,
      description: "The long awaited dream!",
      name: "Trip to the Mars",
    }
  end
end
