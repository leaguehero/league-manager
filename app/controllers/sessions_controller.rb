class SessionsController < Devise::SessionsController

  def new
    # make sure everyone can sign_in on subdomain url
    # override devise to check subdomain
    if (request.subdomain.blank? || request.subdomain == "www")
      flash[:alert] = "This page is restricted!"
      redirect_to :root
    else
      super
    end
  end

  def create
    if current_user && @league.user_id != current_user.id
      sign_out current_user
      flash[:alert] = "Only the league admin can sign in to this page!"
      redirect_to :back
    else
      super
    end
  end

end
