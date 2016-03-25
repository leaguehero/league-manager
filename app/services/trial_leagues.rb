class TrialLeagues

  def self.remove
    League.all.each do |lg|
      if !lg.paid && (TrialLeagues.trail_days_left(lg) <= 0)
        Apartment::Tenant.drop(lg.subdomain)
        lg.destroy
      end
    end
  end

  def self.trail_days_left(league)
    start_date = Date.parse((league.created_at).to_s)
    end_date = start_date + 7
    p (end_date - Date.today).to_i
    return (end_date - Date.today).to_i
  end
end
