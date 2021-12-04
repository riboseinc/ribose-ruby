require "webmock/rspec"
require "bundler/setup"
require "ribose"
require "ribose/rspec"

Dir["./spec/support/**/*.rb"].sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :all do
    Ribose.configure do |ribose_config|
      ribose_config.user_email = ENV["RIBOSE_USER_EMAIL"] || "RIBOSE_USER_EMAIL"
      ribose_config.user_password = ENV["RIBOSE_USER_PASSWORD"] || "SECRET_PASS"
      ribose_config.client = Ribose::Client.new
    end
  end
end
