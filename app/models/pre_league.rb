class PreLeague < ActiveRecord::Base
  belongs_to :user

  # we check subdomain here since we use PreLeague to create League
  validates :league_name, :subdomain, :max_teams, :max_players_per_team, presence: true
  validate :subdomain_is_unique,:at_least_two_teams, on: :create
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

   def at_least_two_teams
     if self.max_teams && self.max_teams < 2
       errors.add(:max_teams, "should be at least 2")
     end
   end

end
