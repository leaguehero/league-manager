class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
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
    @player = Player.find(params[:id])
    respond_to do |format|
      if @player.update_attributes(player_params)
        format.html { redirect_to(@player, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@player) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@player) }
      end
    end
  end

  def destroy

  end

  private

# Need to add permitted params for Rails 4
  def player_params
    params.require(:player).permit(:name, :email, :team_id)
  end
end
