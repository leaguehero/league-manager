require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before(:each) do
    #Needed so we don't get schema errors
    Apartment::Tenant.drop("test")
    @league = create(:league)
  end

  describe "#index" do
    it "navigates to index page with teams set" do
      @team1 = create(:team)
      @team2 = create(:team)

      get :index

      expect(response.status).to eq(200)
    end

    it "builds teams when there are none" do
      controller.instance_variable_set(:@league, @league)

      get :index
      controller.instance_variable_get(:@teams)

      expect(controller.instance_variable_get(:@teams).count).to eq(@league.max_teams)
    end
  end

  describe "#show" do
    it "creates players if none are present" do
      @team1 = create(:team)

      controller.instance_variable_set(:@league, @league)

      get :show, id: @team1.id

      expect(controller.instance_variable_get(:@players).count).to eq(@league.max_players_per_team)

    end

    it "doesn't create players if some are present" do
      @team1 = create(:team)
      @player = create(:player, team_id: @team1.id)

      controller.instance_variable_set(:@league, @league)
      controller.instance_variable_set(:@players, @player)

      get :show, id: @team1.id

      expect(controller.instance_variable_get(:@players).count).to eq(1)

    end
  end

  describe "#edit" do
    it "makes sure user is signed in for team edits" do
      user = login_with create(:user)
      @team1 = create(:team)
      @player = create(:player, team_id: @team1.id)

      controller.instance_variable_set(:@league, @league)

      get :edit, id: @team1.id

      expect(response.status).to eq(200)

    end

    it "creates players if none are present" do
      user = login_with create(:user)

      @team1 = create(:team)

      controller.instance_variable_set(:@league, @league)

      get :edit, id: @team1.id

      expect(controller.instance_variable_get(:@players).count).to eq(@league.max_players_per_team)

    end
  end

  describe "#update" do
    it "updates team when sent propper params" do
      user = login_with create(:user)
      @team1 = create(:team)

      post :update, id: @team1.id, team: {name: "New Name"}

      expect(controller.instance_variable_get(:@team)["name"]).to eq("New Name")

    end
  end

end
