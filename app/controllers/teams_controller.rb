class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @league = League.find_by_subdomain(request.subdomain)

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
    @league = League.find_by_subdomain(request.subdomain)

    id = params[:id]
    @league = League.find(1)
# check if any players are on the team
    @players  = Player.where(:team_id => id)
    if @players.blank?
        @count = 1
        # create max amount of players when they first come to the team edit page
        @league.max_players_per_team.times {
          @player_name  = "Player Name #{@count}"
          Player.create(
          name: @player_name,
          team_id: id
          )
          @count += 1
        }
    end
    @players = Player.where(:team_id => id)
    @team = Team.find(id)
  end

  def edit
    @league = League.find_by_subdomain(request.subdomain)

    id = params[:id]
    @league = League.find(1)
# check if any players are on the team
    @players  = Player.where(:team_id => id)
    if @players.blank?
        @count = 1
        # create max amount of players when they first come to the team edit page
        @league.max_players_per_team.times {
          @player_name  = "Player Name #{@count}"
          Player.create(
          name: @player_name,
          team_id: id
          )
          @count += 1
        }
    end
    @players = Player.where(:team_id => id)
    @team = Team.find(id)
  end

  respond_to :html, :json
  def update
    @team = Team.find(params[:id])
    @team.update_attributes(params[:team])
    respond_with @team
  end

  def destroy

  end

  private

# Need to add permitted params for Rails 4
  def team_params
    params.require(:team).permit(:name, :captain, :asst_captain, :coach, :points_for, :points_against)
  end
end
