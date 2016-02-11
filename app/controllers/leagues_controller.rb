class LeaguesController < ApplicationController

# can use except or only to specify pages
  before_action :authenticate_user!

  def edit

  end

  respond_to :html, :json
  def update
    @league.update_attributes(league_params)
    respond_with @league
  end

  private

# Need to add permitted params for Rails 4
  def league_params
    params.require(:league).permit(:name, :subdomain, :url, :max_teams, :max_players_per_team, :admin_name, :admin_email)
  end
end
