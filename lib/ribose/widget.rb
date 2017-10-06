module Ribose
  class Widget < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "widget"
    end
  end
end
