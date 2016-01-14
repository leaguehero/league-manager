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
    @team_ids = @teams.pluck(:id)
    @game_times = params["game_times"].split(", ")
    @fields = params["field_names"].split(", ")
    @wdays = params["game_days"]

    # move this to be called on button submit from view
    schedule = RRSchedule::Schedule.new(
      #array of teams that will compete against each other. If you group teams into multiple flights (divisions),
      #a separate round-robin is generated in each of them but the "physical constraints" are shared
      :teams => @team_ids,

      #Setup some scheduling rules
      :rules => [
        RRSchedule::Rule.new(:wday => 0, :gt => @game_times, :ps => @fields),
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
    # loop over each day games are played
    @schedule.gamedays.each do |day|
      # loop over all games played on that day
      day.games.each do |gm|
        # create games per game generated
        Game.create(
        team_one: gm.team_a,
        team_two: gm.team_b,
        location: gm.playing_surface,
        time:     gm.game_time.strftime("%I:%M %p"),
        date:     day.date.strftime("%m/%d/%Y")
        )
      end
    end

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

  def destroy
    Game.find(params[:id]).destroy
    flash[:notice] = "Game was successfully deleted"
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:team_one,:team_two,:winner,:loser,:location,:winner_score,:loser_score,:time,:date)
  end
end
