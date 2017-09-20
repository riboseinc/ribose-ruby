require "ribose/actions/base"

module Ribose
  module Actions
    module Create
      extend Ribose::Actions::Base

      def create
        create_resource[resource_key]
      end

      private

      # Resource
      #
      # This method should return the resource name that should
      # be used to orgnize the request body for create operation
      #
      def resource; end

      # Response key
      #
      # This method should return the key that is used as a root
      # elemenet in the response for create operation, ideally it
      # is same as the `resource` method but some endpoit might
      # need some variation.
      #
      def resource_key
        resource
      end

      # Attribute validations
      #
      # This method will be invoked by the create action to validate the
      # attributes before submitting to the actual endpoint. We can override
      # this one to validate user provider attributes.
      #
      def validate(attributes)
        attributes
      end

      def request_body(attributes)
        { resource.to_sym => validate(attributes) }
      end

      def create_resource
        Ribose::Request.post(resources, request_body(attributes))
      end

      module ClassMethods
        # Create resource
        #
        # @param attributes [Hash] Resoruce attributes
        # @return [Sawyer::Resource] Newly created resource
        #
        def create(attributes)
          new(attributes).create
        end
      end
    end
  end
end
