FactoryGirl.define do
  sequence :name do |n|
    "team#{n}"
  end
end

FactoryGirl.define do
  factory :team, :class => 'Team' do
    name
    captain 1
    points_for 11
    points_against 12
  end
end
