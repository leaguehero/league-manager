class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
    # go to add players page
      redirect_to new_player_path(:team_id => @team.id)
    else
      redirect_to :back, :flash => {:error => @team.errors.full_messages.join(", ")}
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
  def team_params
    params.require(:team).permit(:name, :captain, :asst_captain)
  end
end
