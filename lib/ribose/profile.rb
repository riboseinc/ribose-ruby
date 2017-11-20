module Ribose
  class Profile < Ribose::Base
    include Ribose::Actions::Fetch
    include Ribose::Actions::Update

    def set_login
      update_login_name[resource_key]
    end

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

    # Set login name
    #
    # @param login [String] The user login name
    # @return [Sawyer::Resource] The user profile
    #
    def self.set_login(name, options = {})
      new(login: name, **options).set_login
    end

    private

    def resource
      "user"
    end

    def resources_path
      "people/profile"
    end

    def update_login_name
      Ribose::Request.put(
        "people/users/#{fetch.user_id}",
        resource_key.to_sym => { login: attributes[:login] },
        client: @client,
      )
    end
  end
end
