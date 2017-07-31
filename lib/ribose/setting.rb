module Ribose
  class Setting
    def all
      Ribose::Request.get("settings").data["settings"]
    end

    def self.all
      new.all
    end
  end
end
