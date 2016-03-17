require "rails_helper"

describe PagesHelper do
  describe "#page_title" do
    it "returns the correct ranking of teams" do
      @team1 = create(:team)
      @team2 = create(:team)
      expect(helper.create_rankings[0][1]["wins"] > helper.create_rankings[2][1]["wins"] ).to eq(true)
    end
  end
end
