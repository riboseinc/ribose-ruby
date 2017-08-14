module Ribose
  class Member < Ribose::Base
    include Ribose::Actions::All

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

    private

    attr_reader :space_id

    def resources
      ["spaces", space_id, "members"].join("/")
    end

    def resources_key
      "spaces_users"
    end

    def extract_local_attributes
      @space_id = attributes.delete(:space_id)
    end
  end
end
