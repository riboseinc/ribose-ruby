module Ribose
  class Calendar < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "calendar/calendar"
    end
  end
end
