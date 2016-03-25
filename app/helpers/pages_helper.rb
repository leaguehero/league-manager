module PagesHelper
  def create_rankings
    @rankings = {}
    Team.all.each do |team|
      @rankings[team.name] = {}
      @rankings[team.name]["id"] = team.id
      wins = Game.where(winner: team.id).count
      @rankings[team.name]["wins"] = wins
      @rankings[team.name]["losses"] = Game.where(loser: team.id).count
      # game_count = (Game.where(winner: team.id).count + Game.where(loser: team.id).count)
      # @rankings[team.name]["win_percent"] = (wins / (game_count.nonzero? || 1)).to_f
      # need to update schema before adding ties
      @rankings[team.name]["ties"] = 0
      add_points(team)
    end
    # order rank by games win percentage
    @rankings = @rankings.sort_by{|k,v| v["wins"]}.reverse
  end

  # Adding points against and points for to rankings hash
  def add_points(team)
    games_played = Game.where("team_one = #{team.id} or team_two = #{team.id}")
    @rankings[team.name]["points_for"] = 0
    @rankings[team.name]["points_against"] = 0
    if !games_played.nil?
      games_played.each do |game|
        if !game.winner.nil? && !game.winner_score.nil?
          if team.id == game.winner # if team won, add winner points to PF and losing points to PA
            @rankings[team.name]["points_for"] += game.winner_score
            @rankings[team.name]["points_against"] += game.loser_score
          else # if team lost, add winner points to PA and losing points to PF
            @rankings[team.name]["points_for"] += game.loser_score
            @rankings[team.name]["points_against"] += game.winner_score
          end
        end
      end
    end
  end
end
