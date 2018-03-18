module Ribose
  class SpaceCategory < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      nil
    end

    def resources_path
      "space_categories"
    end
  end
end
