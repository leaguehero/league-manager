class Game < ActiveRecord::Base
  before_save :convert_time

  def convert_time
    self.time = Time.parse(self.time).strftime("%l:%M%p")
  end
end
