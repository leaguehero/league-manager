require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  describe "anonymous user" do
    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    it "should be redirected to first page in " do
      get :new
      expect( response ).to render_template( :new )
    end
  end
end
