desc "Remove all Leagues where the trial date has passed"

task :remove_trial_leagues => :environment do
  puts "Removing Leagues..."
  TrialLeagues.remove
  puts "done."
end
