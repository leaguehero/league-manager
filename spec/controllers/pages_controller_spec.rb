require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before(:each) do
    #Needed so we don't get schema errors
    Apartment::Tenant.drop("test")
  end

  describe "#my" do
    it "redirects to root if no current_user" do
      @request.env['HTTP_REFERER'] = "http://test.host/"
      get :my
      expect(response.location).to eq("http://test.host/")
    end

    it "redirects to subdomain if current_user only has one league" do
      @request.env['HTTP_REFERER'] = "http://test.host/"
      @user = create(:user)
      login_with @user
      @league = create(:league, user_id: @user.id )
      get :my
      expect(response.location).to eq("http://test.leaguehero.io/")
    end
  end
end
