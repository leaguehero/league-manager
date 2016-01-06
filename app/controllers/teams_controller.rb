class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    # there should always only be 1 league per subdomain
    @league = League.find(1)

    @teams = Team.all
    # create max amount of teams when they first come to the team index page
    if @teams.blank?
        @count = 1
        @league.max_teams.times {
          @team_name  = "Team Name #{@count}"
          Team.create(
          name: @team_name
          )
          @count += 1
        }
    end
    @teams = Team.all
  end

  def show

  end

  def edit
    @league = League.find(1)
# check if any players are on the team
    @players  = Player.where(:team_id => params[:id])
    if @players.blank?
        @count = 1
        # create max amount of players when they first come to the team edit page
        @league.max_players_per_team.times {
          @player_name  = "Player Name #{@count}"
          Player.create(
          name: @player_name,
          team_id: params[:id]
          )
          @count += 1
        }
    end
    @players = Player.where(:team_id => params[:id])
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
