class League < ActiveRecord::Base
  # validate :subdomain_is_unique, on: :create
  # after_validation :create_tenant


  # # subdomain should be unique
  #    def subdomain_is_unique
  #      if subdomain.present?
  #        unless Account.find_by_subdomain(subdomain).nil?
  #          errors.add(:subdomain, "is already taken")
  #        end
  #        if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
  #          errors.add(:subdomain, "is not available")
  #        end
  #      end
  #    end



  #  def create_tenant <= we'll need to do this on league model
  #    return false unless self.errors.empty?
  #   #  only create if it's a new tenant
  #     if self.new_record?
  #      Apartment::Tenant.create(subdomain)
  #     end
  #     Apartment::Tenant.switch!(subdomain)
  #  end
end
