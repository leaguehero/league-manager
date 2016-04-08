class LeagueDues
  # loop through leagues and cehck if all dues are paid
  def self.check_if_dues_paid
    @leagues = League.all
    @leagues.each do |league|
      if !league.payment_option.nil?
        Apartment::Tenant.switch!("#{league.subdomain}")
        if Due.all.count == Due.where(paid: true).count
          puts "All dues paid for #{league.name}"
          LeagueMailer.all_dues_paid(league).deliver_now
        end
      end
    end
  end
end
