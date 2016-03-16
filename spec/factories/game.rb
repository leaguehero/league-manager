FactoryGirl.define do
  sequence :location do |n|
    "court #{n}"
  end
end

FactoryGirl.define do
  factory :game, :class => 'Game' do
    team_one      1
    team_two      2
    winner        1
    loser         2
    location
    winner_score  45
    loser_score   44
    time          "10:30PM"
    date          "02/02/02"
  end
end
