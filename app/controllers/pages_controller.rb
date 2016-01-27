class PagesController < ApplicationController
  include PagesHelper

  def show
    if !request.subdomain.blank?
      @league = League.find_by_subdomain(request.subdomain)
      create_rankings
      @posts = Post.all
      # Apartment::Tenant.switch!(request.subdomain)
    end

    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end

end
