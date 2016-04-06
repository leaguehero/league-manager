class DuesController < ApplicationController
  include DuesHelper
  before_action :authenticate_user!, :except => [:pay_dues, :show, :create]
  before_filter :check_for_subdomain

  def index
    @dues = Due.all
    @player_dues = {}
    @dues.each do |due|
      player = Player.find(due.player_id)
      @player_dues[player] = {paid: due.paid}
    end
  end

  def update_dues
    # maunally update user as paid
    due = Due.find_by_player_id(params["player_id"]) #Should only be 1 result
    due.paid = params["paid"]
    due.save!
    redirect_to :back, :flash => {:alert => "Player's dues has been updated"}
  end

  # info page on league pay through LH
  def league_pay

  end
  # remove after modal is set up
  def payment_setup

  end

# roadmap: page to set captians for teams
  def teams_pay

  end

# roadmap: page to set player emails
  def players_pay

  end

# Set the amount the league will cost
  def league_dues
    @teams = Team.all
    @players = Player.all
    if params['payer'] == "teams"
      if @teams.blank?
        redirect_to :back, :flash => {:error => "Oops! It looks like you have not set teams for the league. This is required before we can set up the league dues."} and return
      else
        @teams.each do |tm|
          if tm.captain.nil?
            redirect_to :back, :flash => {:error => "Oops! It looks like you have not set team captains for every team. This is required before we can send out the payment request email."} and return
          end
        end
      end
      @league.payment_option = "teams"
    elsif params['payer'] == "players"
      if @players.blank?
        redirect_to :back, :flash => {:error => "Oops! It looks like you have not set players for the league. This is required before we can set the league dues."} and return
      else
        @players.each do |pl|
          if pl.email.nil?
            redirect_to :back, :flash => {:error => "Missing Emails! It looks like you have not set emails for each player. This is required before we can send out the payment request email."} and return
          end
        end
      end
      @league.payment_option = "players"
    end
    @league.save!
  end

# send emails based on if they want from the players or from the captians
  def dues_email
    if params["price"].blank?
      redirect_to :back, :flash => {:error => "Please set a price for the league"} and return
    end
    @league.price = params["price"]
    @league.save!

    send_dues_email(params)

    redirect_to root_path, :flash => {:alert => "Emails have been sent to the league. To track payments select 'Player Dues' in the settings sidebar menu."} and return
  end

# charge page for league dues
  def pay_dues
    @player = Player.find(params["player_id"])
  end
# for creating the charge
  def create
    @player = Player.find(params["player_id"])

    # set api key for Stripe calls
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    # to convert league price to cents
    @amount = @league.price * 100
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => @amount, # amount in cents, again
        :currency => "usd",
        :source => token,
        :description => @player.name + "'s payment for " + @league.name
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
    due = Due.find_by_player_id(@player.id)
    due.paid = true
    due.save!
    # use this route s refresh confirmation page and send another call to Stripe
    redirect_to "/dues/show?player_id=" + @player.id.to_s
    # stripe checkout
  end

# confirmation page after player pays dues
  def show
    @player = Player.find(params["player_id"])
  end

  private
  # Need to add permitted params for Rails 4
  def due_params
    params.require(:due).permit(:player_id, :paid, :league_id)
  end

end
