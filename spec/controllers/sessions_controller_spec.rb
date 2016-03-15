require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'when creating a session' do

    it 'and the user is not associated with the current league, the user is not allowed to see the page' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user) # Using factory girl as an example
      login_with @user #login in user
      league = create(:league, user_id: 2) #create league with wrong user signing in
      controller.instance_variable_set(:@league, league) #set controller instance variables
      @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new' #set route to be called in test env

      post :create

      expect( flash[:alert] ).to eq( "Only the league admin can sign in to this page!" )

    end

    it 'and the user is  associated with the current league, the user is signed in' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user) # Using factory girl as an example
      login_with @user #login in user
      league = create(:league, user_id: @user.id) #create league with wrong user signing in
      controller.instance_variable_set(:@league, league) #set controller instance variables
      @request.env['HTTP_REFERER'] = 'http://test.host/' #set route to be called in test env

      post :create

      expect( response.location ).to eq("/")

    end

    it 'shows correct error when user sign in failed' do
      # sign_out
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user) # Using factory girl as an example

      get :create, user: user

      expect( flash[:alert] ).to eq( "You need to sign in or sign up before continuing.")

    end

    it 'user is updated with current pre_league_id' do
      # sign_out
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user) # Using factory girl as an example
      login_with user
      @request.env['HTTP_REFERER'] = 'http://test.host/charges/new'

      get :create, { :user => { :pre_league_id => 2 } }, :format => :json

      expect( User.find(user.id).pre_league_id ).to eq(2)

    end

    it 'user is sent to new charge path when signing in from league set up process' do
      # sign_out
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user) # Using factory girl as an example
      login_with user
      @request.env['HTTP_REFERER'] = 'http://test.host/charges/new'

      get :create, { :user => { :pre_league_id => 2 } }, :format => :json

      expect( response.location ).to eq(new_charge_path)

    end

    it 'user is sent to users leagues when signing in from main site' do
      # sign_out
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user) # Using factory girl as an example
      login_with user
      @request.env['HTTP_REFERER'] = 'http://test.host/my-leagues'

      get :create, { :user => {} },:format => :json

      expect( response.location ).to eq("/my-leagues")

    end

  end
end
