module Ribose
  class AppRelation
    include Ribose::Actions::All

    # Fetch An App Relation
    #
    # @param app_relation_id [String] The App Relation Id.
    # @return [Sawyer::Resource]
    #
    def self.fetch(app_relation_id)
      Request.get("app_relations/#{app_relation_id}").app_relation
    end

    private

    def resource_path
      "app_relations"
    end
  end
end
