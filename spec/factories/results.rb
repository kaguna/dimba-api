FactoryBot.define do
  factory :result, class: Result do
    home_goals { Faker::Number.between(0, 5) }
    away_goals { Faker::Number.between(0, 5) }
  end
end