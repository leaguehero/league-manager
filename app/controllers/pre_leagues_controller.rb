class PreLeaguesController < ApplicationController
  def new
    if current_user
      # sign out current user on first page of sign up process
      sign_out current_user
    end
    @pre_league = PreLeague.new
    # @admin = current_user.email
  end
# needed?
  def edit

  end

  def create
    if !params["bot-buster"].blank?
      redirect_to :back, :flash => {:error => "BUSTED you, robot!"}
    else
      @pre_league = PreLeague.new(pre_league_params)
      if @pre_league.save
      # go to user sign_up page with league params
        redirect_to new_user_registration_path(:pre_league_id => @pre_league.id)
      else
        redirect_to :back, :flash => {:error => @pre_league.errors.full_messages.join(", ")}
      end
    end
  end

  private

# Need to add permitted params for Rails 4
  def pre_league_params
    params.require(:pre_league).permit(:subdomain, :url, :league_name, :max_teams, :max_players_per_team)
  end
end
