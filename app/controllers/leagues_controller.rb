class LeaguesController < ApplicationController

# can use except or only to specify pages
  before_action :authenticate_user!

  def index
    @league = "Rob's Rockin Robin"
  end
end
