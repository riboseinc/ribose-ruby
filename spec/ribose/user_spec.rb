require "spec_helper"

RSpec.describe Ribose::User do
  describe ".create" do
    it "creates a new signup request for user" do
      user_attributes = { email: "john.doe@example.com" }
      stub_ribose_app_user_create_api(user_attributes)

      expect do
        Ribose::User.create(user_attributes)
      end.not_to raise_error
    end
  end
end
