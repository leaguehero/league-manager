class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # confirmable makes user do email confirmation before signing in
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async

  validate :email_is_unique, on: :create
  validate :subdomain_is_unique, on: :create

  after_validation :create_tenant

  after_create :create_account

# override for not needing email confirmation when testing
  #  def confirmation_required?
  #    false
  #  end

   private
# email should be unique on each < Update to allow emails to be used on multiple subdomains
   def email_is_unique
     if email.present?
       unless Account.find_by_email(email).nil?
         errors.add(:email, "is already taken")
       end
     end
   end
# subdomain should be unique
   def subdomain_is_unique
     if subdomain.present?
       unless Account.find_by_subdomain(subdomain).nil?
         errors.add(:subdomain, "is already taken")
       end
       if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
         errors.add(:subdomain, "is not available")
       end
     end
   end

   def create_account
     account = Account.new(:email => email, :subdomain => subdomain)
     account.save!
   end

   def create_tenant
     return false unless self.errors.empty?
    #  only create if it's a new tenant
      if self.new_record?
       Apartment::Tenant.create(subdomain)
      end
      Apartment::Tenant.switch!(subdomain)
   end
end
