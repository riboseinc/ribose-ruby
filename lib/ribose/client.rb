module Ribose
  class Client
    attr_accessor :api_token, :api_email, :user_email,
                  :client_id, :uid, :access_token

    def initialize(options = {})
      @api_token    = options.fetch(:api_token, configuration.api_token).to_s
      @api_email    = options.fetch(:api_email, configuration.api_email).to_s
      @client_id    = options[:client_id]
      @uid          = options[:uid]
      @access_token = options[:access_token]
    end

    # Initiate a ribose client
    #
    # This interface takes email, password, api_email and api_token
    # Then it will do all the underlying work to find out client id and uid
    # Finally it will return a ribose client.
    #
    # @param :email [String] The email for your Ribose account
    # @param :password [String] The password for your account
    # @param :api_email [String] The email for your API account
    # @param :api_token [String] The authentication token for your API account
    # @return [Ribose::Client] A new client with your details
    #
    def self.from_login(email:, password:, api_email: nil, api_token: nil)
      session = Session.create(
        username: email,
        password: password,
        api_email: api_email,
        api_token: api_token
      )

      new(
        api_email:    api_email,
        api_token:    api_token,
        client_id:    session.nil? ? nil : session['client'],
        uid:          session.nil? ? nil : session['uid'],
        access_token: session.nil? ? nil : session['access-token'],
      )
    end

    private

    def configuration
      Ribose.configuration
    end
  end
end
