module Ribose
  class Client
    attr_accessor :api_email, :api_token, :access_token, :uid, :client_id

    def initialize(options = {})
      initialize_client_details(options)
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
    def self.from_login(email:, password:)
      session = Ribose::Session.create(
        username: email, password: password,
      )

      new(
        api_email: Ribose.configuration.api_email,
        api_token: Ribose.configuration.api_token,
        uid: session.uid,
        client_id: session.client,
        access_token: session["access-token"],
      )
    end

    private

    def configuration
      Ribose.configuration
    end

    def initialize_client_details(options)
      @uid = options.fetch(:uid, nil)
      @client_id = options.fetch(:client_id, nil)
      @access_token = options.fetch(:access_token, nil)
      @api_email = options.fetch(:api_email, configuration.api_email)
      @api_token = options.fetch(:api_token, configuration.api_token)
    end
  end
end
