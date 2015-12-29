class League < ActiveRecord::Base

  validate :subdomain_is_unique, on: :create

  before_create :create_tenant


private

  # subdomain should be unique
   def subdomain_is_unique
     if subdomain.present? && (League.all.count > 0)
       unless League.find_by_subdomain(subdomain).nil?
         errors.add(:subdomain, "is already taken")
       end
       if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
         errors.add(:subdomain, "is not available")
       end
     end
   end

   def create_tenant
     return false unless self.errors.empty?
      #  create subdomain
       Apartment::Tenant.create(subdomain)
      #  switch to subdomain schema right away
       Apartment::Tenant.switch!(subdomain)
   end
end
