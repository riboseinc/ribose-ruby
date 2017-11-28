module Ribose
  class User < Ribose::Base
    include Ribose::Actions::Create

    def create
      create_resource
    end

    def activate
      Ribose::Request.post(
        "signup.user",
        custom_option.merge(user: attributes, auth_header: false),
      )
    end

    def delete
      delete_resource
    end

    # Activate a user
    #
    # @param email [String] The registering user email
    # @param password [String] A strong password for login
    # @param otp [String] The OTP received via the email
    # @param attributes [Hash] The other attributes as Hash.
    # @return [Sawyer::Resoruce] The newly activated user
    #
    def self.activate(email:, password:, otp:, **attributes)
      new(attributes.merge(email: email, password: password, otp: otp)).activate
    end

    # Delete a user
    #
    # @param user_id [String] Existing user's UUID
    # @param options [Hash] The query parameter options
    #
    def self.delete(user_id, options = {})
      new(resource_id: user_id, **options).delete
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

    def delete_resource
      Ribose::Request.delete(
        "cancel_registration",
        custom_option.merge(
          user_id: resource_id,
          password: attributes[:password],
          # auth_header: false
        ),
      )
    end
  end
end
