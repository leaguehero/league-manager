module PagesHelper
  def create_rankings
    @rankings = {}
    Team.all.each do |team|
      @rankings[team.name] = {}
      @rankings[team.name]["wins"] = Game.where(winner: team.id).count
      @rankings[team.name]["losses"] = Game.where(loser: team.id).count
      # need to update schema before adding ties
      @rankings[team.name]["ties"] = 0
    end
    # order rank by games won percentage
    @rankings = @rankings.sort_by{|k,v| v["wins"]}.reverse
  end
end
