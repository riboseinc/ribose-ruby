module Ribose
  class Leaderboard < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "leaderboard"
    end

    def resources
      resource
    end

    def resources_path
      "activity_point/leaderboard"
    end
  end
end
