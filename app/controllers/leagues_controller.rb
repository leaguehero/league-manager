class LeaguesController < ApplicationController

# can use except or only to specify pages
  before_action :authenticate_user!

  def edit

  end

  def confirmation
    # find PreLeague from current_user
    @pl = PreLeague.find(current_user.pre_league_id)
    # find league by preleague subdomain
    @league = League.create(
          :name => @pl["league_name"],
          :subdomain => @pl["subdomain"],
          :url => @pl["subdomain"] + ".leaguehero.io",
          :max_teams => @pl["max_teams"],
          :max_players_per_team => @pl["max_players_per_team"],
          :admin_name => current_user.name,
          :admin_email => current_user.email,
          :user_id => current_user.id,
          :paid => false
        )
        # send confirmation mailer
        LeagueMailer.welcome_email(current_user).deliver_now
  end

  def update
    if @league.update_attributes(league_params)
      redirect_to schedule_path
    else
      redirect_to :back, :flash => {:error => @league.errors.full_messages.join(", ")}
    end
  end

  def player_payments

  end

  private

# Need to add permitted params for Rails 4
  def league_params
    params.require(:league).permit(:name, :subdomain, :url, :max_teams, :max_players_per_team, :admin_name, :admin_email, :avatar, :paid, :price, :payment_option)
  end
end
