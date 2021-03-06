module DuesHelper
  def send_dues_email(params)
    if params['payer'] == "teams"
      @teams = Team.all
      # send emails to all captians to pay team dues
      @teams.each do |tm|
        player = Player.find(tm.captain)
        if Due.all.count < @teams.count
          @due = Due.create(
            :player_id => player.id,
            :paid => false,
            :league_id => @league.id
          )
        end
        LeagueMailer.league_dues_email(player, params["price"], @league).deliver_now
      end
    elsif params['payer'] == "players"
      @players = Player.all
      # send emails to all players to pay dues
      @players.each do |pl|
        player = pl
        if Due.all.count < @players.count
          @due = Due.create(
            :player_id => player.id,
            :paid => false,
            :league_id => @league.id
          )
        end
        LeagueMailer.league_dues_email(player, params["price"], @league).deliver_now
      end
    end
  end

  # check for subdomain before all dues actions
  def check_for_subdomain
    if request.subdomain.blank?
      redirect_to root_path and return
    end
  end

  def find_team(team_id)
    @team_name = Team.find(team_id).name
  end
end
