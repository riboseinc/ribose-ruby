module Ribose
  class MemberRole < Ribose::Base
    include Ribose::Actions::Fetch

    # Fetch Member Role
    #
    # @param space_id [String] The Space UUID
    # @param user_id [String] The Member UUID
    # @param options [Hash] Query parameters as Hash
    # @return [Sawyer::Resoruce] Mmeber role in space
    #
    def self.fetch(space_id, user_id, options = {})
      new(resource_id: user_id, query: { in_space: space_id }, **options).fetch
    end

    private

    def resource
      nil
    end

    def resource_path
      ["people", "users", resource_id, "roles", "get_roles"].join("/")
    end
  end
end
