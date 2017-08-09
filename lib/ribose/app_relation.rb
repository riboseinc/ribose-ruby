module Ribose
  class AppRelation
    # List App Relations
    #
    # @param options [Hash] Query params as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.all(options = {})
      Request.get("app_relations", query: options).app_relations
    end

    # Fetch An App Relation
    #
    # @param app_relation_id [String] The App Relation Id.
    # @return [Sawyer::Resource]
    #
    def self.fetch(app_relation_id)
      Request.get("app_relations/#{app_relation_id}").app_relation
    end
  end
end
