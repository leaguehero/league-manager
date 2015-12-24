class PreLeaguesController < ApplicationController
  def new
    @pre_league = PreLeague.new
    # @admin = current_user.email
  end

  def edit

  end

  def create
    @pre_league = PreLeague.create(pre_league_params)

    # go to user sign_up page with league params
    redirect_to new_user_registration_path(:pre_league_id => @pre_league.id)

  end

  private

# Need to add permitted params for Rails 4
  def pre_league_params
    params.require(:pre_league).permit(:admin_name, :subdomain, :url, :league_name, :max_teams, :max_players_per_team, :admin_email)
  end
end
