module Ribose
  class AppData
    include Ribose::Actions::All

    private

    def resource_path
      "app_data"
    end
  end
end
