require "uri"
require "ostruct"
require "net/http"

module Ribose
  class Session
    def initialize(username, password)
      @username = username
      @password = password
    end

    def create
      authenticate_user
    rescue NoMethodError, JSON::ParserError
      raise Ribose::Unauthorized
    end

    def self.create(username:, password:)
      new(username, password).create
    end

    private

    attr_reader :username, :password

    def authenticate_user
      response = submit_user_login_request

      case response
      when Net::HTTPSuccess
        build_session_data(response.each_header.to_h)
      when Net::HTTPForbidden
        raise(Ribose::Unauthorized)
      end
    end

    def submit_user_login_request
      Net::HTTP.start(login_uri.host, login_uri.port, http_options) do |http|
        request = Net::HTTP::Post.new(login_uri)

        request["Content-Type"] = "application/json"
        request.set_form_data(username: username, password: password)

        http.request(request)
      end
    end

    def api_host
      api_host = Ribose.configuration.api_host

      unless api_host[/\Ahttp:\/\//] || api_host[/\Ahttps:\/\//]
        "https://#{api_host}"
      end
    end

    def login_uri
      @login_uri ||= URI.parse([api_host, "api/v2/auth/sign_in"].join("/"))
    end

    def http_options
      { use_ssl: true, verify_ssl: Ribose.configuration.ssl_verification_mode }
    end

    def build_session_data(headers)
      SessionData.new(headers.slice("uid", "expiry", "client", "access-token"))
    end
  end

  class SessionData < ::OpenStruct
    alias :read_attribute_for_serialization :send
  end
end
