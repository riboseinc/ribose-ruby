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

  def stub_ribose_leaderboard_api
    stub_api_response(
      :get, "activity_point/leaderboard", filename: "leaderboard", status: 200
    )
  end
end
