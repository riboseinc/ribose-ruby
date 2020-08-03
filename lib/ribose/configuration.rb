require "ribose/response/raise_error"

module Ribose
  class Configuration
    attr_accessor :api_host, :api_email, :api_token,
                  :user_email, :user_password,
                  :verify_ssl,
                  :debug_mode

    def initialize
      @debug_mode = false
      @verify_ssl = true
      @api_host ||= "https://www.ribose.com"
    end

    def debug_mode?
      debug_mode == true
    end

    def verify_ssl?
      !!verify_ssl
    end

    def ssl_verification_mode
      verify_ssl? ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
    end

    def add_default_middleware(builder)
      builder.use(Ribose::Response::RaiseError)
      builder.response(:logger, nil, bodies: true) if debug_mode?
      builder.adapter(Faraday.default_adapter)
    end
  end
end
