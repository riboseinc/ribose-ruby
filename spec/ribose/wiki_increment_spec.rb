require "spec_helper"

RSpec.describe Ribose::WikiIncrement do
  describe ".create" do
    it "creates a new wiki page increment" do
      wiki_id = 789_123_567
      space_id = 123_456_789

      increment = Ribose::WikiIncrement.create(
        wiki_id: wiki_id, space_id: space_id, **increment_attrs
      )
    end
  end
  # describe ".all" do
  #   it "retrieves the list of wiki increments" do
  #     wiki_id = 789_123_567
  #     space_id = 123_456_789
  #
  #     increments = Ribose::WikiIncrement.all(space_id, wiki_id)
  #   end
  # end
  #
  def increment_attrs
    {
      revision: 0,
      delta: { ops: [{ insert: "a" }] },
    }
  end
end
