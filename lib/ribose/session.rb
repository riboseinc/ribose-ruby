require "json"
require 'net/http'
require 'uri'
require "ribose/config"

module Ribose
  class Session
    def initialize(username, password, api_email, api_token)
      @username  = username
      @password  = password
      @api_email = api_email
      @api_token = api_token
    end

    def create
      authenticate_user
    end

    def self.create(username:, password:, api_email:, api_token:)
      new(username, password, api_email, api_token).create
    end

    private

    attr_reader :username, :password, :api_email, :api_token

    def authenticate_user
      uri = URI.parse(ribose_url_for("api/v2/auth/sign_in"))
      response = Net::HTTP.start(
        uri.host,
        uri.port,
        use_ssl: true,
        verify_mode: Ribose.configuration.ssl_verification_mode,
      ) do |http|
        request = Net::HTTP::Post.new(uri)
        # set request headers
        request['X-Indigo-Username'] = api_email
        request['X-Indigo-Token']    = api_token
        request['Content-Type']      = 'application/json'

        # set form data
        request.set_form_data(
          'username' => username,
          'password' => password,
        )
        http.request(request)
      end

      # return response headers in hash if success
      return response.each_header.to_h if response.is_a? Net::HTTPSuccess

      nil
    end

    def agent
      @agent ||= Mechanize.new
    end

    def ribose_url_for(*endpoint)
      [Ribose.configuration.api_host, *endpoint].join("/")
    end
  end
end
