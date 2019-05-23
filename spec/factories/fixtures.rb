FactoryBot.define do
  factory :fixture, class: Fixture do
    match_day { Faker::Date.forward(23) }
  end
end
