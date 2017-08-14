module Ribose
  class AppData < Ribose::Base
    include Ribose::Actions::All

    private

    def resources
      "app_data"
    end
  end
end
