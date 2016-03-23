require "rails_helper"

describe PagesHelper do
  describe "#page_title" do
    it "returns the correct ranking of teams" do
      @team1 = create(:team)
      @team2 = create(:team)
      expect(helper.create_rankings[0][1]["wins"] > helper.create_rankings[2][1]["wins"] ).to eq(true)
    end

    it "adds the corrent points to PF and PA" do
      @team1 = create(:team)
      @team2 = create(:team)
      @game1 = create(:game)
      @game2 = create(:game)
      expect(helper.create_rankings[0][1]["points_for"]).to eq(180)
    end
  end
end
