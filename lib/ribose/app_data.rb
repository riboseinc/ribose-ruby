module Ribose
  class AppData < Ribose::Base
    include Ribose::Actions::All

    private

    def resource
      "app_data"
    end

    def resources
      resource
    end
  end
end
