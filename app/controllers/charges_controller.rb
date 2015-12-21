class ChargesController < ApplicationController
  def new

  end

  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 1000,  # Amount in cents, this will be (max number of teams * max players per team) * 100
        :currency => "usd",
        :source => token,
        :description => "Example charge"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end
end
