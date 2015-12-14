class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # confirmable makes user do email confirmation before signing in
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async

  validate :email_is_unique, on: :create
  after_create :create_account

# override for not needing email confirmation when testing
  #  def confirmation_required?
  #    false
  #  end

   private
# email should be unique
   def email_is_unique
    #  Don't validate email if errors are present
     return false unless self.errors[:email].empty?
     unless Account.find_by_email(email).nil?
       errors.add(:email, "is already taken")
     end
   end

   def create_account
     account = Account.new(:email => email)
     account.save!
   end

end
