class League < ActiveRecord::Base

  validate :subdomain_is_unique, on: :create

  before_create :create_tenant

# paperclip attachments for images
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://s3.amazonaws.com/leaguehero/image-sports.png",
                    :storage => :s3
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 0.2.megabytes

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
