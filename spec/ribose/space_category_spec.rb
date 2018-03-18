require "spec_helper"

RSpec.describe Ribose::SpaceCategory do
  describe ".all" do
    it "retrieves the list of space categories" do
      stub_ribose_space_categories_api
      categories = Ribose::SpaceCategory.all

      expect(categories.first.id).not_to be_nil
      expect(categories.first.name).to eq("animals")
    end
  end
end
