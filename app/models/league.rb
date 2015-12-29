class League < ActiveRecord::Base

  validate :subdomain_is_unique, on: :create

  before_create :create_tenant


private

   def create_tenant
     return false unless self.errors.empty?
      #  create subdomain
       Apartment::Tenant.create(subdomain)
      #  switch to subdomain schema right away
       Apartment::Tenant.switch!(subdomain)
   end
end
