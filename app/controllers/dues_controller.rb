class DuesController < ApplicationController
  before_action :authenticate_user!, :except => [:pay_dues, :confirmation]

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
    # if params['teams']
    #   @teams.each do |tm|
    #     if tm.captain.nil?
    #       redirect_to :back, :flash => {:error => "Oops! It looks like you have not set team captains for every team. This is required before we can send out the payment request email."} and return
    #     end
    #   end
    # elsif params['players']
    #   @players.each do |pl|
    #     if pl.email.nil?
    #       redirect_to :back, :flash => {:error => "Missing Emails! It looks like you have not set emails for each player. This is required before we can send out the payment request email."} and return
    #     end
    #   end
    # else
      if params['payer'] == "teams"
        @league.payment_option = "teams"
      elsif params['payer'] == "players"
        @league.payment_option = "players"
      end
      @league.save!
    # end
  end

# send emails based on if they want from the players or from the captians
  def send_dues_email
    if params["price"].blank?
      redirect_to :back, :flash => {:error => "Please set a price for the league"} and return
    end
    @league.price = params["price"]
    @league.save!

    # include player_id in the payment link in order to know who is paying
    redirect_to root_path, :flash => {:alert => "Emails have been sent to the league. To track payments click here () or select 'Payments' under the manage dropdown."} and return
  end

# charge page for league dues
  def pay_dues
    # stripe checkout
  end

# confirmation page after player pays dues
  def confirmation
    # update due object with player Id to paid
  end

  private
  # Need to add permitted params for Rails 4
  def due_params
    params.require(:due).permit(:player_id, :paid, :league_id)
  end

end
