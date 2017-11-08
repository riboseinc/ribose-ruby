require "ribose/actions"

module Ribose
  class Setting < Ribose::Base
    include Ribose::Actions::All
    include Ribose::Actions::Fetch
    include Ribose::Actions::Update
    include Ribose::Actions::Create

    private

    def resource
      "setting"
    end
  end
end
