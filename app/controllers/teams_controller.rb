class TeamsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index

    # there should always only be 1 league per subdomain
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
    id = params[:id]
# check if any players are on the team
    @players = Player.where(:team_id => id)
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
    # find players and team
    @players = Player.where(:team_id => id)
    @team = Team.find(id)
    @team_name = @team.name.capitalize

    # pull in all team games and sort by date
    @team_games = Game.where("team_one = #{id} or team_two = #{id}").sort_by &:date
  end

  def edit
    id = params[:id]
# check if any players are on the team
    @players = Player.where(:team_id => id)
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
    # find all players on the team
    @players = Player.where(:team_id => id)
    # convert @players into hash to be compatible with best_in_place
    @pl_select = Hash[@players.each_with_index.map {|index, value| [index.id, index.name]}]
    @team = Team.find(id)
  end

# updating using best_in_place
  respond_to :html, :json
  def update
    @team = Team.find(params[:id])
    @team.update_attributes(team_params)
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
