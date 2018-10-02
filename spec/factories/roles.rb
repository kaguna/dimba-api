FactoryBot.define do
  factory :role, class: Role do
    description { Faker::Lorem.paragraph }
  end
end
