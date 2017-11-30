module Ribose
  module StubConfigurationHelper
    def stub_configuration
      config = Ribose::Configuration.new
      allow(Ribose).to receive(:configuration).and_return(config)
      yield config if block_given?
    end
  end
end

RSpec.configure { |c| c.include Ribose::StubConfigurationHelper }
