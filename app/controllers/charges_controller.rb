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
      # The card has been declined
    end
    @league = League.find(1)
  end
end
