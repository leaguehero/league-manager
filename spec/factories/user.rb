# set emails for user in tests
FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

# set user for tests
FactoryGirl.define do
  factory :user, :class => 'User' do
    email
    password '12345678'
    password_confirmation '12345678'
    pre_league_id 1
  end
end
