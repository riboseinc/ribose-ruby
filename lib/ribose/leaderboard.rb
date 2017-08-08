module Ribose
  class Leaderboard
    include Ribose::Actions::All

    private

    def resource_path
      "activity_point/leaderboard"
    end
  end
end
