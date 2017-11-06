module Ribose
  class Profile < Ribose::Base
    include Ribose::Actions::Fetch
    include Ribose::Actions::Update

    # Fetch user profile
    #
    # @param options [Hash] The query parameters
    # @return [Sawyer::Resource] The user profile
    #
    def self.fetch(options = {})
      new(resource_id: nil, **options).fetch
    end

    # Update user profile
    #
    # @param attributes [Hash] The new attributes
    # @return [Sawyer::Resource] The user profile
    #
    def self.update(attributes)
      new(resource_id: nil, **attributes).update
    end

    private

    def resource
      "user"
    end

    def resources_path
      "people/profile"
    end
  end
end
