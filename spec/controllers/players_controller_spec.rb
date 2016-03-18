require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  before(:each) do
    @user = create(:user)
    login_with @user
  end
  describe "#index" do
    it "makes sure user is logged in" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "#new" do
    it "makes sure user is logged in" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "creates player if params are correct" do

      post :create, player: {name: "Robtest", email: "rob@test.com", phone: "911"}

      @player = controller.instance_variable_get(:@player)

      expect(response.location).to eq("http://test.host/players/new?player_id=#{@player.id}")
    end

    it "redirects to back if params are incorrect" do
      request.env["HTTP_REFERER"] = new_player_path

      post :create, player: {email: " rob@Test.com"}

      @player = controller.instance_variable_get(:@player)

      expect(@player.errors.full_messages.join(", ")).to eq("Name can't be blank")
    end
  end

  describe "#update" do
    it "updates player when sent propper params" do
      @player = create(:player)

      post :update, id: @player.id, player: {name: "New Name", email: "new@email.com"}

      expect(controller.instance_variable_get(:@player)["name"]).to eq("New Name")

    end
  end
  #
  # describe "#destroy" do
  #   it "removes player" do
  #     @player = create(:player)
  #
  #     expect{delete :destroy, id: @player.id}.to change(Post, :count).by(-1)
  #
  #   end
  # end
end
