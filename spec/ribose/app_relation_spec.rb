require "spec_helper"

RSpec.describe Ribose::AppRelation do
  describe ".all" do
    it "retrieves the list og user's app relations" do
      stub_ribose_app_relation_list_api
      app_relations = Ribose::AppRelation.all

      expect(app_relations.count).to eq(5)
      expect(app_relations.first.app_name).to eq("app/home")
      expect(app_relations.first.owner_id).to eq("63116bd1-c08d")
    end
  end

  def stub_ribose_app_relation_list_api
    stub_api_response(:get, "app_relations", filename: "app_relations")
  end
end
