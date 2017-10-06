require "ribose/actions/base"

module Ribose
  module Actions
    module Update
      extend Ribose::Actions::Base

      # Update a resource
      #
      # @return [Sawyer::Resource] Update resource response
      #
      def update
        update_resource[resource_key]
      end

      private

      # Resource
      #
      # This method should return the resource name that should
      # be used to orgnize the request body for create operation
      #
      def resource; end

      # Resource key
      #
      # This method should return the key that is used as a root
      # elemenet in the response for create operation, ideally it
      # is same as the `resource` method but some endpoit might
      # need some variation.
      #
      def resource_key
        resource
      end

      # Resources
      #
      # The plurarl version for the resource / resrouce key.
      #
      def resources
        [resource, "s"].join("")
      end

      def resource_update_path
        [resources, resource_id].join("/")
      end

      def update_resource
        Ribose::Request.put(
          resource_update_path, resource.to_sym => attributes
        )
      end

      module ClassMethods
        # Update a resource
        #
        # @param resource_id [String] The Resource UUID
        # @param attributes [Hash] New attributes as Hash
        # @return [Sawyer::Resource] The Updated Resource
        #
        def update(resource_id, attributes)
          new(attributes.merge(resource_id: resource_id)).update
        end
      end
    end
  end
end
