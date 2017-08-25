require "spec_helper"

RSpec.describe Ribose::Leaderboard do
  describe ".all" do
    it "retrieves the current leader board" do
      stub_ribose_leaderboard_api
      leaderboard = Ribose::Leaderboard.all

      expect(leaderboard.first.name).to eq("John Doe")
      expect(leaderboard.first.login).to eq("john.doe")
    end
  end
end
