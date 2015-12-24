class SessionsController < Devise::SessionsController

  def new
    # make sure everyone can sign_in on subdomain url
    # override devise to check subdomain
    if request.subdomain.blank? || request.subdomain == "www"
      flash[:alert] = "This page is restricted!"
      redirect_to :root
    else
      super
    end
  end

end
