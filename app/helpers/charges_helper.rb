module ChargesHelper
  def set_team_players(team)
    Player.where(team_id: team.id)
  end
end
