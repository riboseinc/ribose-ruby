module Ribose
  class AppRelation < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    private

    def resource
      "app_relation"
    end
  end
end
