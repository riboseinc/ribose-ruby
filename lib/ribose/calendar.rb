module Ribose
  class Calendar < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Delete

    private

    def resource
      "calendar"
    end

    def resources_path
      "calendar/calendar"
    end

    def validate(name:, **attributes)
      attributes.merge(name: name)
    end
  end
end
