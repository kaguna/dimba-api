FactoryBot.define do
  factory :event, class: Event do
    name { Faker::Verb.past }
    description { Faker::Lorem.paragraph }
  end
end
