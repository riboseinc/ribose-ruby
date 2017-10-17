require "ribose/version"
require "ribose/base"
require "ribose/config"
require "ribose/request"
require "ribose/setting"
require "ribose/space"
require "ribose/app_data"
require "ribose/app_relation"
require "ribose/feed"
require "ribose/widget"
require "ribose/stream"
require "ribose/leaderboard"
require "ribose/connection"
require "ribose/calendar"
require "ribose/member"
require "ribose/space_file"
require "ribose/conversation"
require "ribose/message"
require "ribose/space_invitation"
require "ribose/join_space_request"
require "ribose/connection_invitation"
require "ribose/user"

module Ribose
  def self.root
    File.dirname(__dir__)
  end
end
