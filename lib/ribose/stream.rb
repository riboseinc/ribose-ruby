module Ribose
  class Stream < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "stream"
    end

    def resources
      resource
    end
  end
end
