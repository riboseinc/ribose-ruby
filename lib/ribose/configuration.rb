module Ribose
  class Configuration
    attr_accessor :api_host, :api_key, :response_type, :debug_mode

    def initialize
      @api_host = "https://www.ribose.com"

      @debug_mode = false
      @response_type = :object
    end
  end
end
