class PreLeague < ActiveRecord::Base
  belongs_to :user

  # we check subdomain here since we use PreLeague to create League
  validates :admin_name, :league_name, :subdomain, :max_teams, :max_players_per_team, presence: true
  validate :subdomain_is_unique, on: :create
  private

  # subdomain should be unique
   def subdomain_is_unique
     if subdomain.present?
       unless League.find_by_subdomain(subdomain).nil?
         errors.add(:subdomain, "is already taken")
       end
       if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
         errors.add(:subdomain, "is not available")
       end
     end
   end

end
