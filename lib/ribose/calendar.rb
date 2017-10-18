module Ribose
  class Calendar < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create

    def delete
      Ribose::Request.delete(resource_path)
    end

    def self.delete(calendar_id)
      new(resource_id: calendar_id).delete
    end

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
