class RegistrationsController < Devise::RegistrationsController
  def new
    # make sure no one can sign_up on subdomain url
    # override devise to check subdomain
    if request.subdomain.blank? || request.subdomain == "www"
      # dont allow user to sign up if pre_league_id is blank. Must go through league create process.
      if params["pre_league_id"].blank?
        redirect_to :root
      else
        super
      end
    else
      flash[:alert] = "This page is restricted"
      redirect_to :root
    end
  end

  def create
    if !params["bot-buster"].blank?
      redirect_to :back, :flash => {:error => "BUSTED you, robot!"}
    else
      # Devise create path, need it here for custom usage
      user = params["user"]
      sign_up_params = {"name"=>user["name"], "email"=>user["email"], "password"=>user["password"], "password_confirmation"=>user["password_confirmation"], "pre_league_id"=>(user["pre_league_id"].to_i)}

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
  end

  # PUT /resource
# We need to use a copy of the resource because we don't want to change
# the current user in place.
def update
  self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  resource_updated = update_resource(resource, account_update_params)
  yield resource if block_given?
  if resource_updated
    if is_flashing_format?
      flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
      set_flash_message :notice, flash_key
    end
    sign_in resource_name, resource, bypass: true
    respond_with resource, location: after_update_path_for(resource)
  else
    clean_up_passwords resource

    redirect_to :back, :flash => {:error => resource.errors.full_messages.join(", ")}
  end
end
  protected

  def after_sign_up_path_for(resource)
    "/leagues/confirmation"
  end

end
