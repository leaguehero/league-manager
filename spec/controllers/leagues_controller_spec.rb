require 'rails_helper'

RSpec.describe LeaguesController, type: :controller do
  before(:each) do
    @user = create(:user)
    login_with @user
    #Needed so we don't get schema errors
    Apartment::Tenant.drop("test")
  end

  describe "#update" do
    it "updates league when sent propper params" do
      @league = create(:league)
      controller.instance_variable_set(:@league, @league)
      @request.env['HTTP_REFERER'] = schedule_path #set route to be called in test env

      put :update, id: @league.id, league: {name: "New Name"}

      expect(controller.instance_variable_get(:@league)["name"]).to eq("New Name")

    end
  end
end
