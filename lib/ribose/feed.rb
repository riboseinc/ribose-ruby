module Ribose
  class Feed < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "feed"
    end
  end
end
