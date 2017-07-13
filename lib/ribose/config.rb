require "ribose/configuration"

module Ribose
  module Config
    def configure
      if block_given?
        yield configuration
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  # This following line exposes `Ribose::Config` moduel's methods in class
  # scope, so we can easily use those to configure or access Ribose config
  # throughout the gem and the client applications.
  #
  extend Config
end
