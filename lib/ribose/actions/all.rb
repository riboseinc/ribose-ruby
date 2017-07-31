require "ribose/actions/base"

module Ribose
  module Actions
    module All
      extend Ribose::Actions::Base

      def all
        Ribose::Request.get(resource_path).data[resource_key.to_s]
      end

      def resource_key
        resource_path
      end

      module ClassMethods
        def all
          new.all
        end
      end
    end
  end
end
