module Ribose
  class Connection < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Delete

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
      new(options.merge(query: { s: "" })).all
    end

    # List connection suggestions
    #
    # @param options [Hash] Query parameters as a Hash
    # @return [Array <Sawyer::Resource>]
    #
    def self.suggestions(client: nil, **options)
      Request.get("people_finding", client: client, query: options).
        suggested_connection
    end

    # Disconnect
    #
    # Disconnect connection / contact with the provided
    # connection id. This will return nothing for successful
    # request, but if disconnect fails then it will raise an
    # Error for the client.
    #
    # @params resource_id [Integer] Connection Id
    # @return nil
    #
    def self.disconnect(resource_id, options = {})
      delete(resource_id, options)
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
