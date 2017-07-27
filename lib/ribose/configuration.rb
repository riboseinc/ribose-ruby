module Ribose
  class Configuration
    attr_accessor :api_host, :api_token, :user_email

    def initialize
      @api_host ||= "www.ribose.com"
    end
  end
end
