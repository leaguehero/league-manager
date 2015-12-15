class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper ApplicationHelper

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Change layout marketing/application
  layout :define_layout

  def define_layout
    # if devise_controller? && resource_name == :user
    #   "devise"
    if params["controller"] == "pages"
      "market"
    else
      "application"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :subdomain
  end

end
