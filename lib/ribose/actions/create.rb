require "ribose/actions/base"

module Ribose
  module Actions
    module Create
      extend Ribose::Actions::Base

      def create
        response = create_resource
        response[resource] || response
      end

      private

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
        custom_option.merge(resource_key.to_sym => validate(**attributes))
      end

      def create_resource
        Ribose::Request.post(resources_path, request_body(attributes))
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
