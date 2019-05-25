FactoryBot.define do
  factory :season, class: Season do
    name { Faker::Stripe.year }
    description { Faker::Lorem.paragraph }
    duration { Faker::Number.between(1, 5) }
  end
end