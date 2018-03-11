module Ribose
  class Event < Ribose::Base
    # List calendar events
    #
    # @params calendar_id [Integer] Calendar Ids
    # @params options [Hash] The options parameters
    # @return [Sawyer::Resource] Calendar Events
    #
    def self.all(calendar_id, options = {})
      Ribose::Calendar.fetch(calendar_id, options)
    end
  end
end
