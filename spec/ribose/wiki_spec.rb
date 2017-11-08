require "spec_helper"

RSpec.describe Ribose::Wiki do
  describe ".all" do
    it "retrieves the list of wiki pages" do
      space_id = 123_456

      stub_ribose_wiki_list_api(space_id)
      wikis = Ribose::Wiki.all(space_id)

      expect(wikis.count).to eq(2)
      expect(wikis.first.name).to eq("Wiki Page One")
      expect(wikis.last.name).to eq("Wiki Page Two")
    end
  end
end
