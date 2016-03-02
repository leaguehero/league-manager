class ChargesController < ApplicationController
  def new
    if current_user
      @pl = PreLeague.find(current_user.pre_league_id)
      @amount  = (@pl.max_teams * @pl.max_players_per_team)
    end
  end

  def create
    # set api key for Stripe calls
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    pl = PreLeague.find(current_user.pre_league_id)
    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    league = pl["league_name"]
    @amount  = (pl[:max_teams] * pl[:max_players_per_team])
    @amount_in_cents = @amount * 100
    # Create the charge on Stripe's servers - this will charge the user's card
    begin

      # check for card errors
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
    # Do everything after the payment has been set up
    # create league specific plan
    begin
      Stripe::Plan.create(
        :amount => @amount_in_cents,
        :interval => "year",
        :name => pl["league_name"]+ " League Plan" ,
        :currency => "usd",
        :id => pl["league_name"],
        :trial_period_days => 30
      )
      # create stripe customer
      stripe_customer = Stripe::Customer.create(
      :source => token,
      :email => current_user.email,
      :plan => pl["league_name"],
      :description => "Admin for " + pl["league_name"]
      )
    rescue
      # plan and customer were already created, move on
    end


    # build league if card goes through
    League.create(
      :name => pl["league_name"],
      :subdomain => pl["subdomain"],
      :url => pl["subdomain"] + ".leaguehero.io",
      :max_teams => pl["max_teams"],
      :max_players_per_team => pl["max_players_per_team"],
      :admin_name => current_user.name,
      :admin_email => current_user.email,
      :user_id => current_user.id
    )

    # update current_user with subdomain
    user = User.find_by_email(current_user.email)
    # add stripe id to user
    user.stripe_id = stripe_customer.id
    user.save!
    # use this route so user can'tD refresh confirmation page and send another call to Stripe
    redirect_to "/charges/confirmation"
  end

# all functionality in this route should be moved to the league controller.
  def confirmation
    # find PreLeague from current_user
    @pl = PreLeague.find(current_user.pre_league_id)
    # find league by preleague subdomain
    @league = League.find_by_subdomain(@pl.subdomain)
  end
end
