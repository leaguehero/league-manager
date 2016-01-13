class GamesController < ApplicationController
  # include RRSchedule

  # don't protect on genrate games post request
  protect_from_forgery except: :generate_games

  before_action :authenticate_user!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    @game = Game.new(game_params)
    if @game.save
    # go to add games page
      redirect_to games_path(:game_id => @game.id)
    else
      redirect_to :back, :flash => {:error => @game.errors.full_messages.join(", ")}
    end
  end

  def generator_options
    # TODO: Add validation to make sure the admin has added teams
    # @game = Game.new
  end

  def generate_games
    @teams = Team.all
    @team_names = @teams.pluck(:name)
    @game_times = params["game_times"].split(",")
    @fields = params["field_names"].split(",")
    byebug

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
      :start_date => Date.parse(params["start_date"]),

      #array of dates to exclude
      :exclude_dates => [Date.parse("2010/11/24"),Date.parse("2010/12/15")],

      #Number of times each team must play against each other (default is 1)
      :cycles => params["cycles"].to_i,

      #Shuffle team order before each cycle. Default is true
      :shuffle => true

    )
    @schedule = schedule.generate

    redirect_to games_path
  end

  def edit
    @game = Game.find(params[:id])
    @teams = Team.all
  end

  def update
    @game = Game.find(params[:id])
    respond_to do |format|
      if @game.update_attributes(game_params)
        format.html { redirect_to(@game, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@game) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@game) }
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:team_one,:team_two,:winner,:loser,:location,:winner_score,:loser_score,:time,:date)
  end
end
