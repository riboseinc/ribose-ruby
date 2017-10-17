module Ribose
  class User < Ribose::Base
    include Ribose::Actions::Create

    def create
      create_resource
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
