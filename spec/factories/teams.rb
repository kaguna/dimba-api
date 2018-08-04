FactoryBot.define do

  factory :team, class: Team do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    location { Faker::Name.name }
    nickname { Faker::Name.name }
  end
end
