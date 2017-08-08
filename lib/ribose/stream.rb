module Ribose
  class Stream
    include Ribose::Actions::All

    private

    def resource_path
      "stream"
    end
  end
end
