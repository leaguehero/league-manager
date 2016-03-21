module PagesHelper
  def create_rankings
    @rankings = {}
    Team.all.each do |team|
      @rankings[team.name] = {}
      @rankings[team.name]["id"] = team.id
      wins = Game.where(winner: team.id).count
      @rankings[team.name]["wins"] = wins
      @rankings[team.name]["losses"] = Game.where(loser: team.id).count
      game_count = (Game.where(winner: team.id).count + Game.where(loser: team.id).count)
      @rankings[team.name]["win_percent"] = (wins / (game_count.nonzero? || 1)).to_f
      # need to update schema before adding ties
      @rankings[team.name]["ties"] = 0
    end
    # order rank by games win percentage
    @rankings = @rankings.sort_by{|k,v| v["win_percent"]}.reverse
  end
end
