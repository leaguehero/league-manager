class League < ActiveRecord::Base

  after_create :create_tenant

private

   def create_tenant
     return false unless self.errors.empty?
       Apartment::Tenant.create(subdomain)
   end
end
