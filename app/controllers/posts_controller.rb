class PostsController < ApplicationController
  def index
    @posts = Post.all
    @league = League.find_by_subdomain(request.subdomain)
  end

  def new
    @post = Post.new
    @league = League.find_by_subdomain(request.subdomain)

  end

  def create
    @post = Post.new(post_params)
  end

  def update

  end

  def edit
    @league = League.find_by_subdomain(request.subdomain)
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
