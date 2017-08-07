module Ribose
  class Widget
    include Ribose::Actions::All

    private

    def resource_path
      "widgets"
    end
  end
end
