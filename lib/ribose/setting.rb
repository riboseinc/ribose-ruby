require "ribose/actions"

module Ribose
  class Setting
    include Ribose::Actions::All

    # Fetch A Specific Setting
    #
    # @param setting_id [String] The setting Id
    # @return [Sawyer::Resource]
    #
    def self.fetch(setting_id)
      Request.get("settings/#{setting_id}").setting
    end

    private

    def resource_path
      "settings"
    end
  end
end
