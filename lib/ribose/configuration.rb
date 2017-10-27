require "ribose/response/raise_error"

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

    def web_url
      ["https", api_host].join("://")
    end
    def add_default_middleware(builder)
      builder.use(Ribose::Response::RaiseError)
      builder.response(:logger, nil, bodies: true) if debug_mode?
      builder.adapter(Faraday.default_adapter)
    end
  end
end
