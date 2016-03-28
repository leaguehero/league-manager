class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.order(created_at: :desc).limit(8)
  end

  def new
    @post = Post.new
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

  def edit
    id = params[:id]
    @post = Post.find(id)
  end

  def update
    @post = Post.find(params[:id])
    if @post.save
    # go to posts page
      redirect_to posts_path
    else
      redirect_to :back, :flash => {:error => @post.errors.full_messages.join(", ")}
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Post was successfully deleted"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
