class PostsController < ApplicationController
  def index
    @posts = Post.all
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

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to(@post, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@post) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@post) }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
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
