module RescueApartmentMiddleWare

  def call(*args)
    begin
      # calls Apartment middleware first
      super
    rescue Apartment::TenantNotFound
      return [404, {"Content-Type" => "text/html"}, ["#{File.read(Rails.root.to_s+ '/public/404.html')}"]]
    end
  end

end
