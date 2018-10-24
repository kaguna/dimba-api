FactoryBot.define do
  factory :league, class: League do
    title { Faker::Football.competition }
  end
end
