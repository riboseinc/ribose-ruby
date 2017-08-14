require "ribose/actions"

module Ribose
  class Space < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    private

    def resources
      "spaces"
    end
  end
end
