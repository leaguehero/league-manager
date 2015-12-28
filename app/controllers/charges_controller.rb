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

    # build league if card goes through
    pl = PreLeague.find(current_user.pre_league_id)
    League.create(
    :name => pl["league_name"],
    :subdomain => pl["subdomain"],
    :url => pl["subdomain"] + ".leaguehero.io",
    :max_teams => pl["max_teams"],
    :max_players_per_team => pl["max_players_per_team"],
    :admin_name => pl["admin_name"],
    :admin_email => current_user.email
    )
    # use this route so user can't refresh confirmation page and send another call to Stripe
    redirect_to "/charges/confirmation"
  end

# all functionality in this route should be moved to the league controller.
  def confirmation
    # find PreLeague to convert over to League
    pl = PreLeague.find(current_user.pre_league_id)
    @league = League.find_by_subdomain(pl["subdomain"])
# update user with subdomain
    user = User.find_by_email(current_user.email)
    user.subdomain = pl["subdomain"]
    user.save!
  end
end
