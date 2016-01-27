class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
  end

  def update

  end

  def edit

  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
