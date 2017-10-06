module Ribose
  class Connection < Ribose::Base
    include Ribose::Actions::All

    # List Connections
    #
    # Note: Currently, There are some chaching in place for this endpoint
    # which requires us to pass the `s` query params otherwise we might
    # have some unexpected behavior sometime. That's why we are adding
    # the `s` incase that's not present with the query options.
    #
    # @param options [Hash] Query parameters as a Hash
    # @return [Sawyer::Resource]
    #
    def self.all(options = {})
      new.all(options.merge(query: { s: "" }))
    end

    # List connection suggestions
    #
    # @param options [Hash] Query parameters as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.suggestions(options = {})
      Request.get("people_finding", query: options).suggested_connection
    end

    private

    def resource
      "connection"
    end

    def resources_path
      "people/connections"
    end
  end
end
