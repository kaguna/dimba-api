FactoryBot.define do
  factory :fixture, class: Fixture do
    season { Faker::Number.between(2014, 2019) }
    match_day { Faker::Date.forward(23) }
  end
end
