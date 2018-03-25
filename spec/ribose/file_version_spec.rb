require "spec_helper"

RSpec.describe Ribose::FileVersion do
  describe ".fetch" do
    it "retrieves the details of a file version" do
      file_id = 123_456
      space_id = 456_789
      version_id = 789_012

      stub_ribose_file_version_fetch_api(space_id, file_id, version_id)
      file_version = Ribose::FileVersion.fetch(
        space_id: space_id, file_id: file_id, version_id: version_id,
      )

      expect(file_version.version).to eq(1)
      expect(file_version.author).to eq("John Doe")
      expect(file_version.current_version_id).to eq(789012)
    end
  end

  describe ".create" do
    it "create a new file version" do
      file_id = 123_456
      space_id = 456_789

      stub_ribose_space_file_upload_api(space_id, file_attributes, file_id)
      file = Ribose::FileVersion.create(space_id, file_id, file_attributes)

      expect(file.id).not_to be_nil
      expect(file.author).to eq("John Doe")
      expect(file.content_type).to eq("image/png")
    end
  end

  def file_attributes
    {
      file: sample_fixture_file,
      description: "Version 2.0",
      tag_list: "tags for new version",
    }
  end

  def sample_fixture_file
    @sample_fixture_file ||= File.join(Ribose.root, "spec/fixtures/sample.png")
  end
end
