require "spec_helper"

RSpec.describe Ribose::FileUploader do
  describe ".upload" do
    context "with valid data" do
      it "creates a new upload with details" do
        space_id = 123_456_789

        stub_ribose_space_file_upload_api(space_id, file_attributes)
        file_upload = Ribose::FileUploader.upload(space_id, **file_attributes)

        expect(file_upload.attachment.id).not_to be_nil
        expect(file_upload.attachment.author).to eq("John Doe")
        expect(file_upload.attachment.content_type).to eq("image/png")
      end
    end

    context "with unknown file type" do
      it "creates a new upload as octet-stream" do
        space_id = 123_456_789
        attributes = file_attributes(File.join(Ribose.root, "Rakefile"))

        stub_ribose_space_file_upload_api(space_id, attributes)
        file_upload = Ribose::FileUploader.upload(space_id, **attributes)

        expect(file_upload.attachment.id).not_to be_nil
        expect(file_upload.attachment.author).to eq("John Doe")
      end
    end
  end

  def file_attributes(file = nil)
    {
      file: file || sample_fixture_file,
      tag_list: "sample, file, samplefile",
      description: "This is a sample file",
    }
  end

  def sample_fixture_file
    @sample_file ||= File.join(Ribose.root, "spec/fixtures/sample.png")
  end
end
