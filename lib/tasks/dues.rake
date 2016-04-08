# call task by running $ rake check_if_all_dues_paid
desc "Check if all the dues are paid for a league"

task :check_if_all_dues_paid => :environment do
  puts "Checking Leagues..."
  LeagueDues.check_if_dues_paid
  puts "done."
end
