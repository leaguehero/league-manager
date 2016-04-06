class DuesController < ApplicationController
  before_action :authenticate_user!, :except => [:pay_dues, :confirmation]
  include DuesHelper

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
    redirect_to :back, :flash => {:alert => "Player has been marked as paid"}
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
      @teams.each do |tm|
        if tm.captain.nil?
          redirect_to :back, :flash => {:error => "Oops! It looks like you have not set team captains for every team. This is required before we can send out the payment request email."} and return
        end
      end
    elsif params['payer'] == "players"
      @players.each do |pl|
        if pl.email.nil?
          redirect_to :back, :flash => {:error => "Missing Emails! It looks like you have not set emails for each player. This is required before we can send out the payment request email."} and return
        end
      end
    else
      if params['payer'] == "teams"
        @league.payment_option = "teams"
      elsif params['payer'] == "players"
        @league.payment_option = "players"
      end
      @league.save!
    end
  end

# send emails based on if they want from the players or from the captians
  def dues_email
    if params["price"].blank?
      redirect_to :back, :flash => {:error => "Please set a price for the league"} and return
    end
    @league.price = params["price"]
    @league.save!

    send_dues_email(params)

    redirect_to root_path, :flash => {:alert => "Emails have been sent to the league. To track payments click here () or select 'Payments' under the manage dropdown."} and return
  end

# charge page for league dues
  def pay_dues
    @player = Player.find(params["player_id"])
    # stripe checkout
  end

# confirmation page after player pays dues
  def confirmation
    # update due object with player_id to paid => true
  end

  private
  # Need to add permitted params for Rails 4
  def due_params
    params.require(:due).permit(:player_id, :paid, :league_id)
  end

end
