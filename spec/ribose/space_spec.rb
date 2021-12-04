require "spec_helper"

RSpec.describe Ribose::Space do
  describe ".all" do
    it "retrieves the list of user spaces" do
      stub_ribose_space_list_api
      spaces = Ribose::Space.all

      expect(spaces.first.id).to eq("0e8d5c16-1a31-4df9-83d9-eeaa374d5adc")
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
      space = Ribose::Space.create(**space_attributes)

      expect(space.id).not_to be_nil
      expect(space.visibility).to eq("invisible")
      expect(space.name).to eq("Trip to the Mars")
    end
  end

  describe ".update" do
    it "updates a space with provided details" do
      space_id = 123_456_789

      stub_ribose_space_update_api(space_id, space_attributes)
      space = Ribose::Space.update(space_id, space_attributes)

      expect(space.id).not_to be_nil
      expect(space.visibility).to eq("invisible")
    end
  end

  describe ".remove" do
    it "removes an existing space" do
      space_uuid = "8c63c209-8b98-41aa-a320-336462476ea1"
      stub_ribose_space_remove_api(space_uuid, confirmation: true)

      expect do
        Ribose::Space.remove(space_uuid, confirmation: true)
      end.not_to raise_error
    end
  end

  describe ".delete" do
    it "deletes an existing space" do
      space_id = 123_456_789
      stub_ribose_space_remove_api(space_id, password_confirmation: 1234)

      expect do
        Ribose::Space.delete(space_id, confirmation: 1234)
      end.not_to raise_error
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
