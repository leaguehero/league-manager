class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper ApplicationHelper

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_mailer_host
  before_filter :league

  # Change layout marketing/application
  layout :define_layout

  # set @league if on subdomain
  def league
    if !request.subdomain.blank?
      @league = League.find_by_subdomain(request.subdomain)
    end
  end

  def define_layout
    if params["controller"] == "pages"
      "market"
    else
      "application"
    end
  end

  protected
  def set_mailer_host
    # Will this work with new user registration
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :subdomain
    devise_parameter_sanitizer.for(:invite)  << :subdomain
  end

end
