class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # confirmable makes user do email confirmation before signing in
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #  ,:confirmable, :async

  # validate :email_is_unique, on: :create

  # after_create :create_account

# override for not needing email confirmation when testing
  #  def confirmation_required?
  #    false
  #  end

  #  private
# email should be unique on each < Update to allow emails to be used on multiple subdomains
  #  def email_is_unique
  #    if email.present?
  #      unless Account.find_by_email(email).nil?
  #        errors.add(:email, "is already taken")
  #      end
  #    end
  #  end

  #  def create_account
  #    account = Account.new(:email => email)
  #    account.save!
  #  end

end
