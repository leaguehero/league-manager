module PagesHelper
  def create_rankings
    @wins = {}
    @losses = {}
    # go through each game and add up how many wins and losses each team has.
    if Game.all.length > 0
      Game.all.each do |game|
        # add to wins hash
        if game.winner.nil?
          next
        else
          @wins[game.winner] ? @wins[game.winner] += 1 : @wins[game.winner] = 1
        end
        # losses
        if game.loser.nil?
          next
        else
          @losses[game.loser] ? @losses[game.loser] += 1 : @losses[game.loser] = 1
        end
      end
    else
      # if no games have been made, default all teams to 0 wins
      Team.all.each do |team|
        @wins[team.id] = 0
        @losses[team.id] = 0
      end
    end
  end
end
