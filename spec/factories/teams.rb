FactoryBot.define do
  factory :team, class: Team do
    name { Faker::Football.team }
    description { Faker::Lorem.paragraph }
    location { Faker::Name.name }
    nickname { Faker::Name.name }
  end
end
