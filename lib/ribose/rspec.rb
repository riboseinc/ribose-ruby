# RSpec Test Helpers
#
# Actual API requests are slow and expensive and we try not to make
# actual request when possible. For most of our tests we mock those
# API call which verifies the endpoint, http verb and headers and
# based on those it responses with an identical fixture file
#
# The main purpose of this file is to allow the user to use our test
# helpers by simplify adding this file to their application and then
# use the available helper  method when necessary.
#
# We do not require this module with the gem by default, but you can
# do so by adding `require "ribose/rspec"` on top of `spec_helper`
#
require File.join(Ribose.root, "spec/support/fake_ribose_api.rb")

RSpec.configure do |config|
  config.include Ribose::FakeRiboseApi
end
