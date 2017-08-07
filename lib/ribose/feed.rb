module Ribose
  class Feed
    include Ribose::Actions::All

    private

    def resource_path
      "feeds"
    end
  end
end
