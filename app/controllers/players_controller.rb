class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(playerparams)
    if @player.save
    # go to add players page
      redirect_to new_player_path(:player_id => @player.id)
    else
      redirect_to :back, :flash => {:error => @player.errors.full_messages.join(", ")}
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

# Need to add permitted params for Rails 4
  def playerparams
    params.require(:player).permit(:name, :email, :team_id)
  end
end
