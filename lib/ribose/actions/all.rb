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
        response = Ribose::Request.get(resource_path, query: options)
        extract_root(response) || response
      end

      private

      def resource_key
        resource_path
      end

      def extract_root(response)
        unless resource_key.nil?
          response[resource_key.to_s]
        end
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
          new.all(options)
        end
      end
    end
  end
end
