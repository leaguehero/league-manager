class DuesController < ApplicationController
  def league_pay

  end
  # remove after modal is set up
  def payment_setup

  end

# roadmap
  def teams_pay

  end
# roadmap
  def players_pay

  end

  def league_dues
    # @teams = Team.all
    # @players = Player.all
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
    # end
  end
end
