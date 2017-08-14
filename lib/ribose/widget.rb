module Ribose
  class Widget < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "widgets"
    end
  end
end
