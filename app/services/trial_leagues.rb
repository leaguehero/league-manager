class TrialLeagues

# remove subdomin when trial runs out, then destroy league 7 days after trial ends
  def self.remove
    League.all.each do |lg|
      if !lg.paid && (TrialLeagues.trail_days_left(lg) == 0)
        p "subdomain #{lg.subdomain} has been deleted"
        Apartment::Tenant.drop(lg.subdomain)
      elsif !lg.paid && (TrialLeagues.trail_days_left(lg) <= -7)
        p "league id:#{lg.id}, name:#{lg.name} has been deleted"
        lg.destroy
      end
    end
  end

# send reminder emails based on days left
  def self.send_email_reminder
    League.all.each do |lg|
      @user = User.find(lg.user_id)
      @days_left = TrialLeagues.trail_days_left(lg)
      if !lg.paid
        if @days_left == 3
          LeagueMailer.three_days_left(@user, lg).deliver_now
        elsif @days_left == 1
          LeagueMailer.one_day_left(@user, lg).deliver_now
        elsif @days_left == 0
          LeagueMailer.trial_last_day(@user, lg).deliver_now
        elsif @days_left == -6
          LeagueMailer.deleting_league_notice(@user, lg).deliver_now
        end
      end
    end
  end

# set the amount of trial days are left in the league's trial period
  def self.trail_days_left(league)
    start_date = Date.parse((league.created_at).to_s)
    end_date = start_date + 6
    return (end_date - Date.today).to_i
  end

end
