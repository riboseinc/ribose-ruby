require "ribose/response/raise_error"

module Ribose
  class Configuration
    attr_accessor :api_email, :verify_ssl, :client, :api_host,
                  :api_token, :user_email, :user_password, :debug_mode

    def initialize
      @debug_mode = false
      @verify_ssl = true
      @api_host ||= "www.ribose.com"
    end

    def debug_mode?
      debug_mode == true
    end

    def verify_ssl?
      !!verify_ssl
    end

    def api_email
      @user_email || @api_email
    end

    def client
      @client ||= Ribose::Client.from_login(
        email: api_email, password: user_password,
      )
    end

    def add_default_middleware(builder)
      builder.use(Ribose::Response::RaiseError)
      builder.response(:logger, nil, bodies: true) if debug_mode?
      builder.adapter(Faraday.default_adapter)
    end

    def ssl_verification_mode
      verify_ssl? ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
    end
  end
end
