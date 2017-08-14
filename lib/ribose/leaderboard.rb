module Ribose
  class Leaderboard < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "activity_point/leaderboard"
    end
  end
end
