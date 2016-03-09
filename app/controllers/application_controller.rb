class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper ApplicationHelper

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_mailer_host
  before_filter :set_league_count
  before_filter :set_league

  protected
  def set_mailer_host
    # Will this work with new user registration
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :subdomain
    devise_parameter_sanitizer.for(:invite)  << :subdomain
  end

  def set_league_count
    if current_user.present?
      @user_league_count = League.where(user_id: current_user.id).length
    end
  end

  def set_league
    # set @league if on subdomain
    if !request.subdomain.blank?
      @league = League.find_by_subdomain(request.subdomain)
    end
  end

end
