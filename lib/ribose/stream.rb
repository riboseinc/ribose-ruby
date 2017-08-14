module Ribose
  class Stream < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "stream"
    end
  end
end
