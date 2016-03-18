require 'rails_helper'

RSpec.describe PreLeaguesController, type: :controller do
  before(:each) do
    @user = create(:user)
    login_with @user

  end
  describe "#new" do
    it "logs out current_user on first page of sign up process" do

      get :new

      expect( warden.authenticated?(:user)).to eq(false)
    end
  end

  describe "#create" do
    it "creates PreLeague successfully" do

      post :create, pre_league: {league_name: "Test", max_teams: 10, max_players_per_team: 10, subdomain: "test"}
      @pre_league = controller.instance_variable_get(:@pre_league)

      expect(response.location).to eq("http://test.host/users/sign_up?pre_league_id=#{@pre_league.id}")
    end
    it "doesn't create league with less than 2 teams" do

      post :create, pre_league: {league_name: "Test", max_teams: 1, max_players_per_team: 10, subdomain: "test"}
      @pre_league = controller.instance_variable_get(:@pre_league)

      expect( @pre_league.errors.full_messages.join(", ")).to eq("PreLeague max teams should be at least 2")
    end
    # it "doesn't create league when subdomain name is taken" do
    #
    #   post :create
    #
    #   expect( warden.authenticated?(:user)).to eq(false)
    # end
  end

end
