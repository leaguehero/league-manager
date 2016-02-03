class Game < ActiveRecord::Base
  before_create :convert_date
  before_create :convert_time

  def convert_date
    self.date = Date.parse(self.date).strftime("%m/%d/%Y")
  end

  def convert_time
    self.time = Time.parse(self.time).strftime("%I:%M %p")
  end
end
