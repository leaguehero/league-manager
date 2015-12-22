class RegistrationsController < Devise::RegistrationsController
  def new
    # make sure no one can sign_up on subdomain url
    # override devise to check subdomain
    if request.subdomain.blank? || request.subdomain == "www"
      super
    else
      flash[:alert] = "This page is restricted"
      redirect_to :root
    end
  end

  # redirect_to new_charge_path
  protected
  #
  def after_sign_up_path_for(resource)
    # '/an/example/path' # Or :prefix_to_your_route
    # new_user_session_url(subdomain: resource.subdomain)
    "/charges/new"
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_url(subdomain: resource.subdomain)
  end
end
