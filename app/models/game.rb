class Game < ActiveRecord::Base
  before_save :convert_time
  validate :vs_teams_are_different
  validate :winner_and_loser_are_different, :winner_score_is_higher_than_loser_score, :tie_game, on: :update

  private
  def convert_time
    self.time = Time.parse(self.time).strftime("%l:%M%p")
  end

  def vs_teams_are_different
    if self.team_one == self.team_two
      errors.add(:game, "teams cannot be the same")
    end
  end

  def winner_and_loser_are_different
    if self.winner.present? && self.loser.present?
      if self.winner == self.loser
        errors.add(:game, "winner and loser cannot be the same")
      end
    end
  end

  def winner_score_is_higher_than_loser_score
    if !self.tie && (self.winner_score.present? && self.loser_score.present?)
      if self.winner_score < self.loser_score
        errors.add(:game, "winner score must be higher than loser score")
      end
    end
  end

  def tie_game
    if self.tie && !self.winner_score.present?
      errors.add(:game, "must have a score")
    end
  end

  # def winner_score_is_higher_than_loser_score
  #   if self.winner_score < self.loser_score
  #     errors.add(:game, "winner score must be higher than loser score")
  #   end
  # end
end
