require "ribose/actions/base"

module Ribose
  module Actions
    module Fetch
      extend Ribose::Actions::Base

      # Fetch A Resource
      #
      # Retrieve the details for a specific resource via HTTP GET
      # and retrurns those as `Sawyer::Resource`.
      #
      # @return [Sawyer::Resource]
      #
      def fetch
        response = Request.get([resources, resource_id].join("/"))
        extract_resource(response) || response
      end

      private

      # Single Resource
      #
      # Returns the singular version of the resoruces, and if some
      # resource usages different pattern then we can override this
      # method and that return value will be used.
      #
      # @return [String]
      #
      def resource_key
        resources[0...-1]
      end

      def extract_resource(response)
        unless resource_key.nil?
          response[resource_key.to_s]
        end
      end

      module ClassMethods
        # Fetch A Resource
        #
        # This exposes the `#fetch` instance method as class methods. Once
        # this methods is invoked then it will create an instnace with all
        # of the provided attributes & then invoke the `fetch` action on it
        #
        # @param resource_id [String] The specific resource Id
        # @return [Sawyer::Resource]
        #
        def fetch(resource_id)
          new(resource_id: resource_id).fetch
        end
      end
    end
  end
end
