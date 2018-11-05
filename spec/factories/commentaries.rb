FactoryBot.define do
  factory :commentary, class: Commentary do
    description { Faker::Lorem.paragraph }
    commentary_time { Faker::Number.between(1, 100) }
  end
end
