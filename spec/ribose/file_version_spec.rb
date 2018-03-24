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
end
