require "ribose/actions/base"

module Ribose
  module Actions
    module All
      extend Ribose::Actions::Base

      def all
        response = Ribose::Request.get(resource_path)
        extract_root(response) || response
      end

      def resource_key
        resource_path
      end

      def extract_root(response)
        unless resource_key.nil?
          response[resource_key.to_s]
        end
      end

      module ClassMethods
        def all
          new.all
        end
      end
    end
  end
end
