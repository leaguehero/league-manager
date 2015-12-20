class LeaguesController < ApplicationController

# can use except or only to specify pages
  # before_action :authenticate_user!

  def index
    @league = "Rob's Rockin Robin"
  end

  def new
    @league = League.new
    # @admin = current_user.email
  end

  def edit

  end

  def create
    @league = League.create(league_params)

    if @league.save
      redirect_to root_path, notice: "Thank you for signing up!"
    else
      render "/new"
    end
  end

  def payment_page
    # last page for signup and submit payment
  end

  def process_payment
    # post request to stripe to process payemnt
    # if payment goes through, create league and user,
    # else show payment_page with errors
  end

  def confirmation
    # confirmation page. Show Thank you note and link to league subdomain.  
  end

  def update

  end

  private

# Need to add permitted params for Rails 4
  def league_params
    params.require(:league).permit(:name, :url, :league_name, :max_teams, :max_players_per_team, :admin)
  end
end
