class ChargesController < ApplicationController
  def new
    if current_user && params["league_id"]
      @pl = League.find(params["league_id"])
      @amount  = (@pl.max_teams * @pl.max_players_per_team)
    else
      redirect_to root_path
    end
  end

  def create
    # set api key for Stripe calls
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    pl = League.find(params["league_id"])
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
      )
      # create stripe customer
      stripe_customer = Stripe::Customer.create(
      :source => token,
      :email => current_user.email,
      :plan => pl["league_name"],
      :description => "Admin for " + pl["league_name"]
      )
      # update current_user with subdomain
      user = User.find_by_email(current_user.email)
      # add stripe id to user
      user.stripe_id = stripe_customer.id
      user.save!
    rescue
      # plan and customer were already created, move on
    end
    pl.paid = true
    pl.save!
    # use this route s refresh confirmation page and send another call to Stripe
    redirect_to "/charges/confirmation?league_id=#{pl.id}"
  end

  def confirmation
    # find league by preleague subdomain
    @league = League.find(params["league_id"])
  end
end
