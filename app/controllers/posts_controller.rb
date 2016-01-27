class PostsController < ApplicationController
  def index

  end

  def new

  end

  def create

  end

  def update

  end

  def edit

  end

  def destroy

  end

  private
  
  def game_params
    params.require(:post).permit(:title,:body)
  end
end
