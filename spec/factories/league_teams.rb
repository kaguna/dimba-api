FactoryBot.define do
  factory :league_teams, class: LeaguesTeam do
    association :team, factory: :team
    association :league, factory: :league
  end
end
