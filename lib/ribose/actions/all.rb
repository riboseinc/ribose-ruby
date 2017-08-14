require "ribose/actions/base"

module Ribose
  module Actions
    module All
      extend Ribose::Actions::Base
      # List Resources
      #
      # Retrieve the list of resources via :get and then extract the
      # the root element from the response object.
      #
      # @param options [Hash] Query parameters as a Hash
      # @return [Array <Sawyer::Resource>]
      #
      def all(options = {})
        response = Ribose::Request.get(resources, options)
        extract_root(response) || response
      end

      private

      # Resources Key
      #
      # This value represents the root element in the API response.
      # Currently, Ribose is using the plural resource name as the
      # the key.
      #
      # By default we will use that to extract the details, but if
      # some resource are different then we can override this and
      # that will be used instead.
      #
      # @return [String]
      #
      def resources_key
        resources.to_s
      end

      def extract_root(response)
        unless resources_key.nil?
          response[resources_key]
        end
      end

      # Temporary - Not to break everything right away
      def resources
        resource_path
      end

      module ClassMethods
        # List Resources
        #
        # This exposes the instance method as class methods, and once
        # invoked then it instantiate a new instance & invokes the all
        # instance method with the provided parameters.
        #
        # @param options [Hash] Query parameters as Hash
        # @return [Array <Sawyer::Resource>]
        #
        def all(options = {})
          new.all(query: options)
        end
      end
    end
  end
end
