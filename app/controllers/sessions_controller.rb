class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, :only => :create

  def create # hijacking Devise to customize when we create sessions and how if affects the user
    if current_user && (@league && @league.user_id != current_user.id) #failed sign in to a subdomain
      sign_out current_user
      flash[:alert] = "Only the league admin can sign in to this page!"
      redirect_to :back
    elsif current_user && (@league && @league.user_id == current_user.id) #successful sign in to subdomain
        super
    else #this is for returning users signing in on main site
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      if !session[:return_to].blank?
        redirect_to session[:return_to]
        session[:return_to] = nil
      elsif params["user"]["pre_league_id"].blank? # successful sign in from main site
        respond_with resource, :location => "/my-leagues"
      else # successful sign in when creating a league
        # update user with new pre_league_id
        user = User.find(current_user.id)
        user.pre_league_id = params["user"]["pre_league_id"]
        user.save!
        # send user to payment page
        respond_with resource, :location => "/charges/new"
      end
    end
  end

end
