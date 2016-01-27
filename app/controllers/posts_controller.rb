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
    if @post.save
    # go to add posts page
      redirect_to posts_path(:post_id => @post.id)
    else
      redirect_to :back, :flash => {:error => @post.errors.full_messages.join(", ")}
    end
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
