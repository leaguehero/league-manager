class ChargesController < ApplicationController
  def new

  end

  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    league = "entered league name"
    @amount  = (10 * 10) #(params[:max_teams] * params[:max_players_per_team])
    @amount_in_cents = @amount * 100
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => @amount_in_cents,
        :currency => "usd",
        :source => token,
        :description => "Charge for #{league}"
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
    # use this route so user can't refresh confirmation page and send another call to Stripe
    redirect_to "/charges/confirmation"
  end

  def confirmation
    # build league
    # delete pre league
    # create subdomain
    # add user to subdomain

    @league = PreLeague.find(current_user.pre_league_id)
    # sign out user, no need to keep them logged in. They should only be able to log in on the subdomain site.
    sign_out current_user
  end
end
