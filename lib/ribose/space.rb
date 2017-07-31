require "ribose/actions"

module Ribose
  class Space
    include Ribose::Actions::All

    private

    def resource_path
      "spaces"
    end
  end
end
