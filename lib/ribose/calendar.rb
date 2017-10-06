module Ribose
  class Calendar < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "calendar"
    end

    def resources_path
      "calendar/calendar"
    end
  end
end
