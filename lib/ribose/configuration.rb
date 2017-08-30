module Ribose
  class Configuration
    attr_accessor :api_host, :api_token, :user_email, :debug_mode

    def initialize
      @debug_mode = false
      @api_host ||= "www.ribose.com"
    end

    def debug_mode?
      debug_mode == true
    end
  end
end
