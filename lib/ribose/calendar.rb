require "date"

module Ribose
  class Calendar < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Delete

    # Fetch calendar events
    #
    # @params calendar_ids [Array] List of calendar Ids
    # @params start [Date] The start date to fetch events
    # @params length [Integer] How many days to fetch
    # @return [Sawyer::Resource] The calendar events
    #
    def self.fetch(calendar_ids, start: Date.today, length: 7)
      query = {
        length: length,
        cal_ids: Ribose.encode_ids(calendar_ids),
        start: start.to_time.to_i / (60 * 60 * 24),
      }

      super(nil, query: query)
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
