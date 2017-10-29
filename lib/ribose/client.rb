module Ribose
  class Client
    attr_reader :api_token, :user_email

    def initialize(options = {})
      @api_token = options.fetch(:token, configuration.api_token).to_s
      @user_email = options.fetch(:email, configuration.user_email).to_s
    end

    private

    def configuration
      Ribose.configuration
    end
  end
end
