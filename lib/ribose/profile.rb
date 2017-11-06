module Ribose
  class Profile < Ribose::Base
    include Ribose::Actions::Fetch

    def self.fetch(options = {})
      new(resource_id: nil, **options).fetch
    end

    private

    def resource
      "user"
    end

    def resources_path
      "people/profile"
    end
  end
end
