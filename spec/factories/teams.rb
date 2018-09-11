FactoryBot.define do
  factory :team, class: Team do
    name { Faker::Football.team }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.country }
    nickname { Faker::FunnyName.name }
  end
end