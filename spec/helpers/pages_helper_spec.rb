require "rails_helper"

describe PagesHelper do
  describe "#page_title" do
    it "returns the correct ranking of teams" do
      2.times do
        create(:game)
      end
      create(:team, id: 1)
      create(:team, id: 2)

      expect(helper.create_rankings).to eq([["team 1", {"id"=>1, "wins"=>2, "losses"=>0, "ties"=>0}], ["team 2", {"id"=>2, "wins"=>0, "losses"=>2, "ties"=>0}]])
    end
  end
end
