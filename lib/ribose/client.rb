module Ribose
  class Client
    attr_reader :api_token, :user_email, :client_id, :uid, :access_token

    def initialize(options = {})
      @api_token    = options.fetch(:api_token, configuration.api_token).to_s
      @user_email   = options.fetch(:email, configuration.user_email).to_s
      @client_id    = options.fetch(:client_id).to_s
      @uid          = options.fetch(:uid).to_s
      @access_token = options.fetch(:access_token).to_s
    end

    # Initiate a ribose client
    #
    # This interface takes email, password and api_token
    # Then it will do all the underlying work to find out client id and uid
    # Finally it will return a ribose client.
    #
    # @param :email [String] The email for your Ribose account
    # @param :password [String] The password for your account
    # @param :api_token [String] The authentication token for your account
    # @return [Ribose::Client] A new client with your details
    #
    def self.from_login(email:, password:, api_token:)
      session = Session.create(
        username: email,
        password: password,
        api_token: api_token
      )

      new(
        email:        email,
        api_token:    api_token,
        client_id:    session['client'],
        uid:          session['uid'],
        access_token: session['access-token'],
      )
    end

    private

    def configuration
      Ribose.configuration
    end
  end
end
