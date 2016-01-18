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
    if current_user && (current_user.subdomain != request.subdomain)
      # byebug
      sign_out current_user
      redirect_to :back, :flash => {:error => "Only the league admin can sign in to this page!"}
    else
      # Apartment::Tenant.switch!("")
      super
    end
  end

end
