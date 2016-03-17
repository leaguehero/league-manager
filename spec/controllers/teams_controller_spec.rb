require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before(:each) do
    # this might break when first running these tests
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

end
