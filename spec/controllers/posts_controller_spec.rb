require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @user = create(:user)
    login_with @user
  end
  describe "#index" do
    it "makes sure user is logged in" do
      get :index
      expect(response.status).to eq(200)
    end

    it "shows posts in correct order" do
      create(:post)
      create(:post)
      get :index
      expect(controller.instance_variable_get(:@posts)[0]["title"]).to eq("Test Post2")
    end
  end

  describe "#new" do
    it "makes sure user is logged in" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "creates post if params are correct" do

      post :create, post: {title: "Test Post", body: "Body Test"}

      @post = controller.instance_variable_get(:@post)

      expect(response.location).to eq("http://test.host/posts?post_id=#{@post.id}")
    end

    it "redirects to back if params are incorrect" do
      request.env["HTTP_REFERER"] = new_post_path

      post :create, post: {body: "Body Test"}

      @post = controller.instance_variable_get(:@post)

      expect(@post.errors.full_messages.join(", ")).to eq("Title can't be blank")
    end
  end

  describe "#update" do
    it "updates team when sent propper params" do
      @post = create(:post)

      post :update, id: @post.id, post: {title: "New Name", body: "new body"}

      expect(controller.instance_variable_get(:@post)["title"]).to eq("New Name")

    end

    it "updates team when sent propper params" do
      @post = create(:post)

      post :update, id: @post.id, post: {title: "New Name"}

      expect(@post.errors.full_messages.join(", ")).to eq("Body can't be blank")

    end
  end

  describe "#destroy" do
    it "removes post" do
      @post = create(:post)

      expect{delete :destroy, id: @post.id}.to change(Post, :count).by(-1)

    end
  end
end
