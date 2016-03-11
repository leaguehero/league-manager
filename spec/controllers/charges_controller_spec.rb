require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  describe "When user navigates to new charge page" do

    it "should be redirected to first page in " do
      login_with nil
      get :new
      expect( response ).to render_template( :new )
    end

    it "should be able to find a PreLeague with the current_user " do
      current_user = login_with create(:user)
      @pl = create(:pre_league)

      get :new, current_user: current_user

      expect(@pl).to eq(PreLeague.find(1))
    end

  end

  # describe "When user creates a charge" do
  #
  #   it "thats successful, they should be directed to the confirmation page" do
  #     pl = create(:pre_league)
  #     login_with create( :user )
  #
  #     post :create
  #
  #     stub_request(:post, "https://api.stripe.com/v1/plans").
  #        with(:body => {"amount"=>"10000", "currency"=>"usd", "id"=>"test", "interval"=>"year", "name"=>"test League Plan", "trial_period_days"=>"30"},
  #             :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer sk_test_73IGkqKBk65CW2kSCYOReeK1', 'Content-Length'=>'90', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Stripe/v1 RubyBindings/1.36.0', 'X-Stripe-Client-User-Agent'=>'{"bindings_version":"1.36.0","lang":"ruby","lang_version":"2.2.2 p95 (2015-04-13)","platform":"x86_64-darwin14","engine":"ruby","publisher":"stripe","uname":"Darwin Robs-MacBook-Pro.local 14.5.0 Darwin Kernel Version 14.5.0: Tue Sep  1 21:23:09 PDT 2015; root:xnu-2782.50.1~1/RELEASE_X86_64 x86_64","hostname":"Robs-MacBook-Pro.local"}'}).
  #        to_return(:status => 200, :body => "", :headers => {})
  #   end
  # end

  describe "when charge is successful" do
    it "finds the preleague based on current user" do
      current_user = login_with create(:user)
      @pl = create(:pre_league)

      get :confirmation, current_user: current_user

      expect(@pl).to eq(PreLeague.find(1))
    end

    it "finds the league by preleague subdomain" do
      current_user = login_with create(:user)
      @pl = create(:pre_league)
      @league = create(:league)

      get :confirmation, current_user: current_user

      expect(@league).to eq(League.find_by_subdomain(@pl.subdomain))
    end
  end
end
