require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before(:all) do

    team1 = create(:team)
    team2 = create(:team)

    create(:game, team_one: team1.id, team_two: team2.id, winner: team1.id, loser: team2.id)
    create(:game, team_one: team1.id, team_two: team2.id, winner: team1.id, loser: team2.id)
  end
  describe "#index" do

    it "should show the game months in the correct order" do
      get :index

      expect(controller.instance_variable_get(:@game_months)).to eq(["All", "Jan","Feb"])
    end

    it "should show the games in the correct order" do
      get :index

      expect(controller.instance_variable_get(:@current_games)[1].date).to eq("01/02/2016")
    end

    it "should only show the games in the current month" do

      get :index, :month => 'Jan'

      expect(controller.instance_variable_get(:@current_games)[0].date).to eq("01/02/2016")
    end
  end
end
