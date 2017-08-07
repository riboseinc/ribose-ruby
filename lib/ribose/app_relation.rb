module Ribose
  class AppRelation
    include Ribose::Actions::All

    private

    def resource_path
      "app_relations"
    end
  end
end
