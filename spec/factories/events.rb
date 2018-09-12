FactoryBot.define do
  factory :event, class: Event do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    event_time { Faker::Number.between(1, 100) }
  end
end
