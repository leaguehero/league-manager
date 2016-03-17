require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before(:all) do

    @team1 = create(:team)
    @team2 = create(:team)

    @game1 = create(:game, team_one: @team1.id, team_two: @team2.id, winner: @team1.id, loser: @team2.id)
    @game2 = create(:game, team_one: @team1.id, team_two: @team2.id, winner: @team1.id, loser: @team2.id)
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

  describe "#new" do
    it "should make sure user is signed in" do

      login_with create(:user)

      get :new

      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "game created successfully" do
      login_with create(:user)

      post :create, game: {team_one: @team1.id, team_two: @team2.id, winner: @team1.id, loser: @team2.id, date: "02/02/02", time: "10:30PM"}
      @game = controller.instance_variable_get(:@game)

      expect(response.location).to eq("http://test.host/schedule?game_id=#{@game.id}")
    end

    it "failed to create game and redirected back with errors" do
      login_with create(:user)
      request.env["HTTP_REFERER"] = new_game_path

      post :create, game: {team_one: @team1.id, team_two: @team1.id, winner: @team1.id, loser: @team2.id, date: "02/02/02", time: "10:30PM"}

      @game = controller.instance_variable_get(:@game)

      expect(@game.errors.full_messages.join(", ")).to eq("Game teams cannot be the same")
    end

    describe "#generator_options" do
      it "@week_days is set" do
        login_with create(:user)

        get :generator_options

        expect(controller.instance_variable_get(:@week_days)).to eq({sunday:0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday:5, saturday: 6})
      end
    end
# this takes too long to test, find out how to shorten time <= passes
    # describe "#generate_games" do
    #   it "generates a league schedule based on generator options" do
    #     login_with create(:user)
    #     request.env["HTTP_REFERER"] = "http://test.host/schedule"
    # 
    #
    #     post :generate_games, game_times: ["9:00PM","10:00PM"],field_names: ["Court 1", "Court 2"],game_days: 0,start_date: "02/02/2016", cycles: 1
    #
    #     expect(response.location).to eq("http://test.host/schedule")
    #   end
    # end

    describe "#edit" do
      it "user is logged in while viewing edit page" do
        login_with create(:user)

        get :edit, id: @game1.id

        expect(response.status).to eq(200)
      end
    end

    describe "#update" do
      it "updates game with edits" do
        login_with create(:user)

        get :edit, id: @game1.id

        expect(response.status).to eq(200)
      end
    end

    describe "#destroy" do
      it "destroys single game" do
        login_with create(:user)

        expect{delete :destroy, id: @game1.id}.to change(Game, :count).by(-1)
      end
    end

    describe "#destroy_all" do
      it "deletes all games" do
        login_with create(:user)
        get :destroy_all
        expect(Game.all.count).to eq(0)
      end
    end
  end
end
