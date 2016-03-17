class Game < ActiveRecord::Base
  before_save :convert_time
  validate :vs_teams_are_different

  private
  def convert_time
    self.time = Time.parse(self.time).strftime("%l:%M%p")
  end

  def vs_teams_are_different
    if self.team_one == self.team_two
      errors.add(:game, "teams cannot be the same")
    end
  end
end
