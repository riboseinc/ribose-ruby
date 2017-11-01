module Ribose
  class Client
    attr_reader :api_token, :user_email

    def initialize(options = {})
      @api_token = options.fetch(:token, configuration.api_token).to_s
      @user_email = options.fetch(:email, configuration.user_email).to_s
    end

    # Initiate a ribose client
    #
    # This interface takes email and password and then it will
    # do all the underlying work to find out the authentication
    # token and retrun a ribose client.
    #
    # @param :email [String] The email for your Ribose account
    # @param :password [String] The password for your account
    # @return [Ribose::Client] A new client with your details
    #
    def self.from_login(email:, password:)
      session = Session.create(username: email, password: password)
      new(email: email, token: session["authentication_token"])
    end

    private

    def configuration
      Ribose.configuration
    end
  end
end
