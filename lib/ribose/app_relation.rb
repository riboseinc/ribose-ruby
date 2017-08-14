module Ribose
  class AppRelation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    private

    def resources
      "app_relations"
    end
  end
end
