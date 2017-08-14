module Ribose
  class Feed < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "feeds"
    end
  end
end
