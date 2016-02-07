class Game < ActiveRecord::Base
  before_save :convert_time

  def convert_time
    self.time = Time.parse(self.time).strftime("%I:%M %p")
  end
end
