FactoryBot.define do
  factory :sponsor, class: Sponsor do
    name { Faker::Bank.name }
    description { Faker::Lorem.paragraph }
    contacts { Faker::Internet.url }
  end
end