module Ribose
  class Member < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Delete

    # List A Space Members
    #
    # This interface retrieves the list of members for any speicfic
    # user spaces and then will return those as `Sawyer::Resource`
    #
    # @param space_id [String] The Space Id
    # @param options [Hash] Query parameters as a Hash
    # @return [Array<Sawyer::Resource>]
    #
    def self.all(space_id, options = {})
      new(space_id: space_id, **options).all
    end

    # Delete a space member
    #
    # @param space_id [String] The Space UUID
    # @param member_id [String] The Member UUID
    # @param options [Hash] Query parameters as Hash
    #
    def self.delete(space_id, member_id, options = {})
      new(space_id: space_id, resource_id: member_id, **options).delete
    end

    private

    attr_reader :space_id

    def resource
      "spaces_user"
    end

    def resources_path
      ["spaces", space_id, "members"].join("/")
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end
  end
end
