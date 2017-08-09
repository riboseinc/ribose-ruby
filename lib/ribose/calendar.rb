module Ribose
  class Calendar
    # List User Calanders
    #
    # @param options [Hash] Query params as Hash
    # @return [Sawyer::Resource]
    #
    def self.all(options = {})
      Request.get("calendar/calendar", query: options)
    end
  end
end
