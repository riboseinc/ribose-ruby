module Ribose
  class MemberRole < Ribose::Base
    include Ribose::Actions::Fetch

    def assign
      assign_member_role
    end

    # Fetch Member Role
    #
    # @param space_id [String] The Space UUID
    # @param user_id [String] The Member UUID
    # @param options [Hash] Query parameters as Hash
    # @return [Sawyer::Resoruce] Mmeber role in space
    #
    def self.fetch(space_id, user_id, options = {})
      new(resource_id: user_id, space_id: space_id, **options).fetch
    end

    # Assign Role to a Member
    #
    # @param space_id [String] The Space UUID
    # @param user_id [String] The Member UUID
    # @param role_id [String] The role id in space
    #
    def self.assign(space_id, user_id, role_id)
      new(space_id: space_id, resource_id: user_id, role_id: role_id).assign
    end

    private

    attr_reader :role_id

    def resource
      nil
    end

    def assign_path
      [resources_path, "change_assignment"].join("/")
    end

    def resource_path
      [resources_path, "get_roles"].join("/")
    end

    def resources_path
      ["people", "users", resource_id, "roles"].join("/")
    end

    def extract_local_attributes
      @role_id = attributes.delete(:role_id)
      @query = { in_space: attributes.delete(:space_id) }
    end

    def assign_member_role
      Ribose::Request.put(
        assign_path, custom_option.merge(checked_role: role_id)
      )
    end
  end
end
