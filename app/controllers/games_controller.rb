class GamesController < ApplicationController

  # don't protect on genrate games post request
  protect_from_forgery except: :generate_games

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @teams = Team.all
    @games = Game.all
    if @games.length > 0
      #set current_month
      @current_month = params["month"] ? Date::ABBR_MONTHNAMES.index(params["month"]) : Date.today.month
      #set current_month name
      @current_month_name = params["month"] ? params["month"] : Date.today.strftime("%b")
      @game_months = ["All"]
      @current_games = [] #set array for games in this month

      @games.each do |gm|
        gm_date = Date.parse(Date.strptime(gm.date,'%m/%d/%Y').to_s) #convert saved game date to Date object

        # create array of months in which there are games present
        @game_months << gm_date.strftime("%b") unless @game_months.include?(gm_date.strftime("%b"))

        gm_month = gm_date.month #if the game month and current month match up, insert it into the array
        if params["month"] == "All"
          @current_games << gm
        elsif gm_month == @current_month
          @current_games << gm
        end
        @current_games.sort! { |a,b| "#{a.date}" + " #{a.time}"  <=> "#{b.date}" + " #{b.time}"  }
      end
    end
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path(:game_id => @game.id)
    else
      redirect_to :back, :flash => {:error => @game.errors.full_messages.join(", ")}
    end
  end

  def generator_options
    @week_days = {sunday:0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday:5, saturday: 6}
    # TODO: Add validation to make sure the admin has added teams
    # @game = Game.new
  end

  def generate_games
    @teams = Team.all
    @team_ids = @teams.pluck(:id)
    @game_times = params["game_times"] unless params["game_times"].nil?
    @fields = params["field_names"] unless params["field_names"].nil?
    # removed for now, they can manually change dates on games or delete them 
    @exclude_dates = params["exclude_dates"].split(", ") unless params["exclude_dates"].nil?

    # TODO: Add ability to have multiple days for games
    @wday = params["game_days"]

    # move this to be called on button submit from view
    schedule = RRSchedule::Schedule.new(
      #array of teams that will compete against each other. If you group teams into multiple flights (divisions),
      #a separate round-robin is generated in each of them but the "physical constraints" are shared
      :teams => @team_ids,

      #Setup some scheduling rules
      :rules => [
          RRSchedule::Rule.new(:wday => @wday.to_i, :gt => @game_times, :ps => @fields),
      ],

      #First games are played on...
      :start_date => Date.parse(params["start_date"]),

      #array of dates to exclude
      :exclude_dates => @exclude_dates,

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
        time:     gm.game_time,
        date:     Date.parse(day.date.to_s).strftime("%m/%d/%Y")
        )
      end
    end

    redirect_to "/schedule"
  end

  def edit
    @game = Game.find(params[:id])
    @game_played = Time.strptime(@game.date,'%m/%d/%Y') < Time.now
    @teams = Team.all
  end

  def update
    @game = Game.find(params[:id])
    # respond_to do |format|
      if @game.update_attributes(game_params)
        redirect_to games_path
      #   format.html { redirect_to(@game, :notice => 'User was successfully updated.') }
      #   format.json { respond_with_bip(@game) }
      else
      #   format.html { render :action => "edit" }
      #   format.json { respond_with_bip(@game) }
        redirect_to :back, :flash => {:error => @game.errors.full_messages.join(", ")}
      end
    # end
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:notice] = "Game was successfully deleted"
    redirect_to games_path
  end

  def destroy_all
    # delete all games created
    Game.where("created_at" < Time.now.to_s).destroy_all
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:team_one,:team_two,:winner,:loser,:location,:winner_score,:loser_score,:time,:date)
  end
end
