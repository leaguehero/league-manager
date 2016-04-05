module DuesHelper
  def send_dues_email(params)
    if params['payer'] == "teams"
      @teams = Team.all
      # send emails to all captians to pay team dues
      @teams.each do |tm|
        email = Player.find(tm.captain).email
        LeagueMailer.league_dues_email(email, params["price"], @league).deliver_now
      end
    elsif params['payer'] == "players"
      @players = Player.all
      # send emails to all players to pay dues
      @players.each do |pl|
        email = pl.email
        LeagueMailer.league_dues_email(email, params["price"], @league).deliver_now
      end
    end
  end
end
