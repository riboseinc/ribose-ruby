module Ribose
  class Setting
    # List user setttings
    #
    # @param options [Hash] Query params as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.all(options = {})
      Request.get("settings", query: options).settings
    end
  end
end
