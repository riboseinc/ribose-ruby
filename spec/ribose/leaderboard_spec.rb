require "spec_helper"

RSpec.describe Ribose::Leaderboard do
  describe ".all" do
    it "retrieves the current leader board" do
      stub_ribose_leaderboard_api
      activity = Ribose::Leaderboard.all

      expect(activity.self_rank).to eq(1)
      expect(activity.overall_rank).to eq(40)
      expect(activity.leaderboard.first.name).to eq("John Doe")
      expect(activity.leaderboard.first.login).to eq("john.doe")
    end
  end

  def stub_ribose_leaderboard_api
    stub_api_response(
      :get, "activity_point/leaderboard", filename: "leaderboard", status: 200
    )
  end
end
