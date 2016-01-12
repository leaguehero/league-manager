class GamesController < ApplicationController
  # include RRSchedule

  before_action :authenticate_user!

  def index
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create

  end

  def generator_options
    # @game = Game.new
  end

  def generate_games
    @teams = Team.all
    @team_names = @teams.pluck(:name)

    # move this to be called on button submit from view
    schedule = RRSchedule::Schedule.new(
      #array of teams that will compete against each other. If you group teams into multiple flights (divisions),
      #a separate round-robin is generated in each of them but the "physical constraints" are shared
      :teams => @team_names,

      #Setup some scheduling rules
      :rules => [
        RRSchedule::Rule.new(:wday => 0, :gt => ["8:00PM","9:00PM","10:00PM"], :ps => ["field #1", "field #2"]),
      ],

      #First games are played on...
      :start_date => Date.parse("2016/03/01"),

      #array of dates to exclude
      :exclude_dates => [Date.parse("2010/11/24"),Date.parse("2010/12/15")],

      #Number of times each team must play against each other (default is 1)
      :cycles => 2,

      #Shuffle team order before each cycle. Default is true
      :shuffle => true
    )
    @schedule = schedule.generate
  end

  private

  def game_params
    params.require(:game).permit(:team_one,:team_two,:winner,:loser,:location,:winner_score,:loser_score,:time,:date)
  end
end
