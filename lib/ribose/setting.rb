require "ribose/actions"

module Ribose
  class Setting < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch

    private

    def resource
      "setting"
    end
  end
end
