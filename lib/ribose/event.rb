module Ribose
  class Event < Ribose::Base
    include Ribose::Actions::Fetch
    include Ribose::Actions::Create
    include Ribose::Actions::Update
    include Ribose::Actions::Delete

    # List calendar events
    #
    # @params calendar_id [Integer] Calendar Ids
    # @params options [Hash] The options parameters
    # @return [Sawyer::Resource] Calendar Events
    #
    def self.all(calendar_id, options = {})
      Ribose::Calendar.fetch(calendar_id, options)
    end

    # Fetch a calendar event
    #
    # @params calendar_id - The calendar ID
    # @params event_id - The calendar event ID
    # @return [Sawyer::Resource] Event details
    #
    def self.fetch(calendar_id, event_id, options = {})
      new(options.merge(calendar_id: calendar_id, resource_id: event_id)).fetch
    end

    # Create a calendar event
    #
    # @params calendar_id - The calendar Id
    # @attributes [Hash] - New Event attributes
    # @return [Sawyer::Resource] The new event
    #
    def self.create(calendar_id, attrs, options = {})
      new(options.merge(calendar_id: calendar_id, **attrs)).create["events"]
    end

    # Update a calendar event
    #
    # @params calendar_id [Integer] The calendar Id
    # @params event_id [Integer] The calendar event Id
    # @params attributes [Hash] New attributes for event
    # @params options [Hash] The additional query params
    #
    def self.update(calendar_id, event_id, attributes, options = {})
      new(options.merge(
            calendar_id: calendar_id, resource_id: event_id, **attributes,
          )).update["events"]
    end

    # Delete a calendar event
    #
    # @params calendar_id The calendar Id
    # @params event_id  The calendar event Id
    # @params options [Hash] The query params
    #
    def self.delete(calendar_id, event_id, options = {})
      new(options.merge(calendar_id: calendar_id, resource_id: event_id)).delete
    end

    private

    attr_reader :calendar_id

    def resource
      "event"
    end

    def validate(date_start:, date_finish:, time_start:, time_finish:, **others)
      others.merge(
        date_start: date_start,
        time_start: time_start,
        date_finish: date_finish,
        time_finish: time_finish,
      )
    end

    def extract_local_attributes
      @calendar_id = attributes.delete(:calendar_id)
    end

    def resources_path
      "calendar/calendar/#{calendar_id}/event"
    end
  end
end
