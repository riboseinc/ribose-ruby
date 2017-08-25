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
end
