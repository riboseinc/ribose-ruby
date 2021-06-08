module Ribose
  class User < Ribose::Base
    include Ribose::Actions::Create

    def create
      create_resource
    end

    def activate
      Ribose::Request.post(
        "api/v2/auth",
        custom_option.merge(
          user: attributes,
          auth_header: false,
          client: Ribose::Client.new,
        ),
      )
    end

    # Activate a user
    #
    # @param email [String] The registering user email
    # @param password [String] A strong password for login
    # @param edata [String] The OTP received via the email
    # @param attributes [Hash] The other attributes as Hash.
    # @return [Sawyer::Resoruce] The newly activated user
    #
    def self.activate(email:, password:, edata: nil, **attributes)
      new(attributes.merge(email: email, password: password,
                           edata: edata)).activate
    end

    private

    def resource
      "user"
    end

    def resources_path
      "signup_requests"
    end

    def validate(email:, **attributes)
      attributes.merge(email: email)
    end
  end
end
