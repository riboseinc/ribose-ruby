require "ribose/actions/base"

module Ribose
  module Actions
    module Delete
      extend Ribose::Actions::Base

      def delete
        Ribose::Request.delete(resource_path, custom_option)
      end

      module ClassMethods
        # Delete a resource
        #
        # @param resource_id [String] Resource UUID
        # @param options [Hash] Query parameters as Hash
        #
        def delete(resource_id, options = {})
          new(resource_id: resource_id, **options).delete
        end

        # Aliases for delete
        #
        # There is another variation `cancel` that we have been using in
        # some resources inter exchangbly, so let's keep that legacy support
        # for now and we can decide about those in the future.
        #
        alias_method :cancel, :delete
      end
    end
  end
end
