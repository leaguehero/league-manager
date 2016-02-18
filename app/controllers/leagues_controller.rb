class LeaguesController < ApplicationController

# can use except or only to specify pages
  before_action :authenticate_user!

  def edit

  end

  def update
    if @league.update_attributes(league_params)
      redirect_to schedule_path
    else
      redirect_to :back, :flash => {:error => @league.errors.full_messages.join(", ")}
    end
  end

  private

# Need to add permitted params for Rails 4
  def league_params
    params.require(:league).permit(:name, :subdomain, :url, :max_teams, :max_players_per_team, :admin_name, :admin_email, :avatar)
  end
end
