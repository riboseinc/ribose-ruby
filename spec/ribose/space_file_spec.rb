require "spec_helper"

RSpec.describe Ribose::SpaceFile do
  describe ".all" do
    it "retrieve files uploaded to a spce" do
      space_id = 123_456_789
      stub_ribose_space_file_list(space_id)

      files = Ribose::SpaceFile.all(space_id)

      expect(files.first.id).not_to be_nil
      expect(files.first.name).to eq("sample-file.png")
      expect(files.first.versions.first.version).to eq(1)
    end
  end

  describe ".create" do
    it "creates a new file with provided details" do
      space_id = 123_456_789

      stub_ribose_space_file_upload_api(space_id, file_attributes)
      file = Ribose::SpaceFile.create(space_id, file_attributes)

      expect(file.id).not_to be_nil
      expect(file.author).to eq("John Doe")
      expect(file.content_type).to eq("image/png")
    end
  end

  def file_attributes
    {
      file: sample_fixture_file,
      description: "This is a sample file",
      tag_list: "Details tag for the file",
    }
  end

  def sample_fixture_file
    @sample_file ||= File.join(Ribose.root, "spec/fixtures/sample.png")
  end
end
