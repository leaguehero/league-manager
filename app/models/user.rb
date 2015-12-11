class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # confirmable makes user do email confirmation before signing in
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

# override for not needing email confirmation when testing
   def confirmation_required?
     false
   end
   
end
