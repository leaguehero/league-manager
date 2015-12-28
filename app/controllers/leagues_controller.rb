class LeaguesController < ApplicationController

# can use except or only to specify pages
  before_action :authenticate_user!

  def index
    @league = "Rob's Rockin Robin"
  end

  def new
    @league = League.new
  end

  def edit
    @league = League.find(params[:id])
  end

  def create

  end

  def confirmation
    # confirmation page. Show Thank you note and link to league subdomain.
  end

  def update

  end

  private

# Need to add permitted params for Rails 4
  def league_params
    params.require(:league).permit(:name, :subdomain, :url, :league_name, :max_teams, :max_players_per_team, :admin)
  end
end
