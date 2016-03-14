# set preleague for tests
FactoryGirl.define do
  factory :pre_league do
    id 1
    league_name "test"
    max_teams 10
    max_players_per_team 10
    subdomain "test"
  end
end

# set league for tests
FactoryGirl.define do
  factory :league do
    id 1
    name "test"
    url "test.leaguehero.io"
    user_id 1
    max_teams 10
    max_players_per_team 10
    subdomain "test"
  end
end
