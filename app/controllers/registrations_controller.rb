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

  def create
    # Devise create path, need it here for custom usage
    user = params["user"]
    sign_up_params = {"email"=>user["email"], "password"=>user["password"], "password_confirmation"=>user["password_confirmation"], "pre_league_id"=>(user["pre_league_id"].to_i)}

    build_resource(sign_up_params)
    if resource.save
        yield resource if block_given?
        if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
        else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
    else
        clean_up_passwords resource
        resource.errors.full_messages.each {|x| flash[x] = x} # Rails 4 simple way
        redirect_to new_user_registration_path(:pre_league_id => params["user"]["pre_league_id"])
    end
  end
  protected

  def after_sign_up_path_for(resource)
    "/charges/new"
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_url(subdomain: resource.subdomain)
  end
end
