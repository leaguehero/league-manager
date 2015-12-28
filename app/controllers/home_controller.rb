class HomeController < ApplicationController
  def index
    # on root directory, signout current_user since there is no sign in here. 
    if current_user && (current_user.subdomain != request.subdomain)
      sign_out current_user
    end
    @message = "WELCOME TO LEAGUE HERO!"
  end
end
