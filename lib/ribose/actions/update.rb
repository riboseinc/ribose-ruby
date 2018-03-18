require "ribose/actions/base"

module Ribose
  module Actions
    module Update
      extend Ribose::Actions::Base

      # Update a resource
      #
      # @return [Sawyer::Resource] Update resource response
      def update
        response = update_resource
        response[resource] || response
      end

      private

      def update_resource
        Ribose::Request.put(
          resource_path, custom_option.merge(resource_key.to_sym => attributes)
        )
      end

      module ClassMethods
        # Update a resource
        #
        # @param resource_id [String] The Resource UUID
        # @param attributes [Hash] New attributes as Hash
        # @return [Sawyer::Resource] The Updated Resource
        def update(resource_id, attributes = {})
          new(attributes.merge(resource_id: resource_id)).update
        end
      end
    end
  end
end
