# call task by running $ rake remove_trial_leagues
desc "Remove all Leagues where the trial date has passed"

task :remove_trial_leagues => :environment do
  puts "Removing Leagues..."
  TrialLeagues.remove
  puts "done."
end

# call task by running $ rake trial_league_email_reminder
desc "Send reminder to trial league admins"

task :trial_league_email_reminder => :environment do
  puts "Sending Emails..."
  TrialLeagues.send_email_reminder
  puts "don."
end
